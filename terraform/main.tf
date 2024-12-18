provider "aws" {
  profile = "myAWS"
  region  = "us-east-1"
}

module "network" {
  source                         = "./modules/network"
  vpc_cidr_block                 = "10.0.0.0/16"
  public_subnet_cidrs            = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs           = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones             = ["us-east-1a", "us-east-1b"]
  enable_nat_gateway             = true
  nat_gateway_eip_allocation_ids = []
  tags                           = { Environment = "dev", Team = "compute" }
  environment                    = "dev"
}

module "compute" {
  source    = "./modules/compute"
  vpc_id    = module.network.vpc_id
  subnet_id = module.network.public_subnet_ids[0] # Choose the first public subnet
  ami_id    = var.ami_id                          # Pass the value from root variables
  #ami_id               = ""                                 # Replace with a valid AMI ID
  instance_type  = var.instance_type  # Use value from `dev.tfvars`
  key_name       = "devops1"          # Replace with your SSH key name
  key_path       = "~/devops1.pem"    # Replace with your SSH key path 
  instance_count = var.instance_count # Pass the value from `dev.tfvars`
  environment    = "dev"
  tags           = { Environment = "dev", Team = "compute" }
}