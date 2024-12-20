# General Configuration
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Security Group Configuration
variable "vpc_id" {
  description = "VPC ID for security group association"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    description        = string
    from_port          = number
    to_port            = number
    protocol           = string
    cidr_blocks        = list(string)
    ipv6_cidr_blocks   = list(string)
    security_group_ids = list(string)
  }))
  default = [
    {
      description        = "Allow SSH from ec2 host",
      from_port          = 22,
      to_port            = 22,
      protocol           = "tcp",
      cidr_blocks        = ["44.193.207.184/32"],
      ipv6_cidr_blocks   = [],
      security_group_ids = []
    },
    {
      description        = "Allow SSH from host machine",
      from_port          = 22,
      to_port            = 22,
      protocol           = "tcp",
      cidr_blocks        = ["50.66.177.15/32"],
      ipv6_cidr_blocks   = [],
      security_group_ids = []
    },
    {
      description        = "Allow SSH from GitHub Self Hosted Runner",
      from_port          = 22,
      to_port            = 22,
      protocol           = "tcp"
      cidr_blocks        = ["34.203.117.224/32"], # Fix this
      ipv6_cidr_blocks   = [],
      security_group_ids = []
    },
    {
      description        = "Allow HTTP",
      from_port          = 80,
      to_port            = 80,
      protocol           = "tcp",
      cidr_blocks        = ["0.0.0.0/0"],
      ipv6_cidr_blocks   = [],
      security_group_ids = []
    },
    {
      description        = "Allow HTTPS",
      from_port          = 443,
      to_port            = 443,
      protocol           = "tcp",
      cidr_blocks        = ["0.0.0.0/0"],
      ipv6_cidr_blocks   = [],
      security_group_ids = []
    },
    {
      description        = "Allow Prometheus",
      from_port          = 9090,
      to_port            = 9090,
      protocol           = "tcp",
      cidr_blocks        = ["0.0.0.0/0"],
      ipv6_cidr_blocks   = [],
      security_group_ids = []
    },
    {
      description        = "Allow Loki",
      from_port          = 3100,
      to_port            = 3100,
      protocol           = "tcp",
      cidr_blocks        = ["0.0.0.0/0"],
      ipv6_cidr_blocks   = [],
      security_group_ids = []
    },
    {
      description        = "Allow Grafana",
      from_port          = 3000,
      to_port            = 3000,
      protocol           = "tcp",
      cidr_blocks        = ["0.0.0.0/0"],
      ipv6_cidr_blocks   = [],
      security_group_ids = []
    },
    {
      description        = "Allow Traefik Dashboard",
      from_port          = 8080,
      to_port            = 8080,
      protocol           = "tcp",
      cidr_blocks        = ["0.0.0.0/0"],
      ipv6_cidr_blocks   = [],
      security_group_ids = []
    }
  ]
}

variable "egress_rules" {
  description = "List of egress rules for the security group"
  type = list(object({
    description       = string
    from_port         = number
    to_port           = number
    protocol          = string
    cidr_blocks       = list(string)
    ipv6_cidr_blocks  = list(string)
  }))
  default = [
    {
      description       = "Allow all outbound",
      from_port         = 0,
      to_port           = 0,
      protocol          = "-1",
      cidr_blocks       = ["0.0.0.0/0"],
      ipv6_cidr_blocks  = []
    }
  ]
}

# EC2 Configuration
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0866a3c8686eaeeba"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "key_path" {
  description = "Path to the private key file for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be deployed"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP with the EC2 instance"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User data script to configure the instance"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "IAM instance profile to associate with the EC2 instance"
  type        = string
  default     = ""
}

# Root Volume Configuration
variable "root_volume_size" {
  description = "Size of the root volume (in GB)"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Type of the root volume (e.g., gp2, gp3, io1)"
  type        = string
  default     = "gp2"
}

variable "route53_zone_id" {
  description = "Route53 Zone ID"
  type        = string
  default     = "Z05768553DXM5B4AIP8FI"
}