terraform {
  backend "s3" {
    bucket         = "cv-challenge03-terraform-state-backend"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "cv-challenge03-terraform-locks"
    encrypt        = true
    profile        = "myAWS"
  }
}