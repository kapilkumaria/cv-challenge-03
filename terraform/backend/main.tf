provider "aws" {
  region = "us-east-1"
  profile = "myAWS"  # Replace with your AWS Profile
}

# Create S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "cv-challenge03-terraform-state-backend" # Replace with your unique bucket name

  acl = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Backend"
  }
}

# Create DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "cv-challenge03-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Locking"
    Environment = "Backend"
  }
}

# Combine S3 and DynamoDB Policies
data "aws_iam_policy_document" "combined_backend_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::cv-challenge02-terraform-state-backend",
      "arn:aws:s3:::cv-challenge02-terraform-state-backend/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:Scan",
      "dynamodb:UpdateItem"
    ]
    resources = [
      "arn:aws:dynamodb:us-east-1:931058976119:table/cv-challenge02-terraform-locks" # Replace with your AWS Account ID
    ]
  }
}

# Create IAM Policy for Terraform Backend Access
resource "aws_iam_policy" "terraform_backend_policy" {
  name        = "TerraformBackendPolicy"
  description = "IAM policy for Terraform to access S3 and DynamoDB backend"
  policy      = data.aws_iam_policy_document.combined_backend_policy.json
}