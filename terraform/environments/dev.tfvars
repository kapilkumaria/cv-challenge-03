# Network Configuration
vpc_cidr_block          = "10.0.0.0/16"
public_subnet_cidrs     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs    = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones      = ["us-east-1a", "us-east-1b"]
enable_dns_support      = true
enable_dns_hostnames    = true
enable_nat_gateway      = true
tags                    = { Environment = "dev", Team = "devops" }
environment             = "dev"

# Compute Configuration
ami_id                  = "ami-0866a3c8686eaeeba" # Replace with a valid AMI ID for dev
instance_type           = "t2.large"
#instance_type           = ""
key_name                = "devops1"               # Replace with your SSH key pair for dev
#key_name = "my-ec2-keypair"
key_path = "~/devops1.pem"
instance_count          = 1                     # Example: 2 instances for the dev environment
user_data               = <<-EOT
#!/bin/bash
echo "Hello, Dev Environment!" > /var/www/html/index.html
EOT