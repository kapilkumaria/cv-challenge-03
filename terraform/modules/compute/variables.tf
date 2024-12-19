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
      cidr_blocks        = ["44.195.82.101/32"],
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
      description        = "Allow SSH from GitHub Runner Range"
      from_port          = 22
      to_port            = 22
      protocol           = "tcp"
      cidr_blocks        = [
                            "4.148.0.0/16",
                            "4.149.0.0/18",
                            "4.149.64.0/19",
                            "4.149.96.0/19",
                            "4.149.128.0/17",
                            "4.150.0.0/18",
                            "4.150.64.0/18",
                            "4.150.128.0/18",
                            "4.150.192.0/19",
                            "4.150.224.0/19",
                            "4.151.0.0/16",
                            "4.152.0.0/15",
                            "4.154.0.0/15",
                            "4.156.0.0/15",
                            "4.175.0.0/16",
                            "4.180.0.0/16",
                            "4.207.0.0/16",
                            "4.208.0.0/15",
                            "4.210.0.0/17",
                            "4.210.128.0/17",
                            "4.227.0.0/17",
                            "4.227.128.0/17",
                            "4.231.0.0/17",
                            "4.231.128.0/17",
                            "4.236.0.0/17",
                            "4.236.128.0/17",
                            "4.242.0.0/17",
                            "4.242.128.0/17",
                            "4.245.0.0/17",
                            "4.245.128.0/17",
                            "4.246.0.0/17",
                            "4.246.128.0/17",
                            "4.249.0.0/17",
                            "4.249.128.0/17",
                            "4.255.0.0/17",
                            "9.163.0.0/16",
                            "9.169.0.0/17",
                            "9.169.128.0/17",
                            "13.64.0.0/16",
                            "13.65.0.0/16",
                            "13.66.0.0/17",
                            "13.66.128.0/17",
                            "13.67.128.0/20",
                            "13.67.144.0/21",
                            "13.67.152.0/24",
                            "13.67.153.0/28",
                            "13.67.153.32/27",
                            "13.67.153.64/26",
                            "13.67.153.128/25",
                            "13.67.155.0/24",
                            "13.67.156.0/22",
                            "13.67.160.0/19",
                            "13.67.192.0/18",
                            "13.68.0.0/17",
                            "13.68.128.0/17",
                            "13.69.0.0/17",
                            "13.69.128.0/17",
                            "13.70.192.0/18",
                            "13.72.64.0/18",
                            "13.73.32.0/19",
                            "13.73.128.0/18",
                            "13.73.224.0/21",
                            "13.73.240.0/20",
                            "13.74.0.0/16",
                            "13.77.64.0/18",
                            "13.77.128.0/18",
                            "13.79.0.0/16",
                            "13.80.0.0/15",
                            "13.82.0.0/16",
                            "13.83.0.0/16",
                            "13.84.0.0/15",
                            "13.86.0.0/17",
                            "13.86.128.0/17",
                            "13.87.112.0/21",
                            "13.87.128.0/17",
                            "13.88.0.0/17",
                            "13.88.128.0/18",
                            "13.88.200.0/21",
                            "13.89.0.0/16",
                            "13.90.0.0/16",
                            "13.91.0.0/16",
                            "13.92.0.0/16",
                            "13.93.0.0/17",
                            "13.93.128.0/17",
                            "13.94.64.0/18",
                            "13.94.128.0/17",
                            "13.95.0.0/16",
                            "13.104.129.64/26",
                            "13.104.144.64/27",
                            "13.104.144.128/27",
                            "13.104.144.192/27",
                            "13.104.145.0/26",
                            "13.104.145.192/26",
                            "13.104.146.0/26",
                            "13.104.146.128/25",
                            "13.104.147.0/25",
                            "13.104.147.128/25",
                            "13.104.148.0/25",
                            "13.104.149.128/25",
                            "13.104.150.0/25",
                            "13.104.152.128/25",
                            "13.104.158.16/28",
                            "13.104.158.64/26",
                            "13.104.158.176/28",
                            "13.104.192.0/21",
                            "13.104.208.64/27",
                            "13.104.208.96/27",
                            "13.104.208.128/27",
                            "13.104.208.160/28",
                            "13.104.208.192/26",
                            "13.104.209.0/24",
                            "13.104.210.0/24",
                            "13.104.211.0/25",
                            "13.104.213.0/25",
                            "13.104.214.0/25",
                            "13.104.214.128/25",
                            "13.104.215.0/25",
                            "13.104.217.0/25",
                            "13.104.218.128/25",
                            "13.104.219.128/25",
                            "13.104.220.0/25",
                            "13.104.220.128/25",
                            "13.104.222.0/24",
                            "13.104.223.0/25",
                            "13.105.14.0/25",
                            "13.105.14.128/26",
                            "13.105.17.0/26",
                            "13.105.17.64/26",
                            "13.105.17.128/26",
                            "13.105.17.192/26",
                            "13.105.18.0/26",
                            "13.105.18.160/27",
                            "13.105.18.192/26",
                            "13.105.19.0/25",
                            "13.105.19.128/25",
                            "13.105.20.192/26",
                            "13.105.21.0/24",
                            "13.105.22.0/24",
                            "13.105.23.0/26",
                            "13.105.23.64/26",
                            "13.105.23.128/25",
                            "13.105.24.0/24",
                            "13.105.25.0/24",
                            "13.105.26.0/24",
                            "13.105.27.0/25",
                            "13.105.27.192/27",
                            "13.105.28.0/28",
                            "13.105.28.16/28",
                            "13.105.28.32/28",
                            "13.105.28.48/28",
                            "13.105.28.128/25",
                            "13.105.29.0/25",
                            "13.105.29.128/25",
                            "13.105.31.96/28",
                            "13.105.36.0/27",
                            "13.105.36.32/28",
                            "13.105.36.64/27",
                            "13.105.36.128/26",
                            "13.105.36.192/26",
                            "13.105.37.0/26",
                            "13.105.37.64/26",
                            "13.105.37.128/26",
                            "13.105.37.192/26",
                            "13.105.49.0/31",
                            "13.105.49.2/31",
                            "13.105.49.4/31",
                            "13.105.49.6/31",
                            "13.105.49.8/31",
                            "13.105.49.10/31",
                            "13.105.49.12/31",
                            "13.105.49.14/31",
                            "13.105.49.16/31",
                            "13.105.49.18/31",
                            "13.105.49.20/31",
                            "13.105.49.22/31",
                            "13.105.49.24/31",
                            "13.105.49.26/31",
                            "13.105.49.28/31",
                            "13.105.49.30/31",
                            "13.105.49.32/31",
                            "13.105.49.34/31",
                            "13.105.49.36/31",
                            "13.105.49.38/31",
                            "13.105.49.40/31",
                            "13.105.49.42/31",
                            "13.105.49.44/31",
                            "13.105.49.46/31",
                            "13.105.49.48/31",
                            "13.105.49.50/31",
                            "13.105.49.52/31",
                            "13.105.49.54/31",
                            "13.105.49.56/31",
                            "13.105.49.58/31",
                            "13.105.49.60/31",
                            "13.105.49.62/31",
                            "13.105.49.64/31",
                            "13.105.49.66/31",
                            "13.105.49.68/31",
                            "13.105.49.70/31",
                            "13.105.49.72/31",
                            "13.105.49.74/31",
                            "13.105.49.76/31",
                            "13.105.49.78/31",
                            "13.105.49.80/31",
                            "13.105.49.82/31",
                            "13.105.49.84/31",
                            "13.105.49.86/31",
                            "13.105.49.88/31",
                            "13.105.49.90/31",
                            "13.105.49.92/31",
                            "13.105.49.94/31",
                            "13.105.49.96/31",
                            "13.105.49.98/31",
                            "13.105.49.100/31",
                            "13.105.49.102/31",
                            "13.105.49.104/31",
                            "13.105.49.106/31",
                            "13.105.49.108/31",
                            "13.105.49.110/31",
                            "13.105.49.112/31",
                            "13.105.49.114/31",
                            "13.105.49.116/31",
                            "13.105.49.118/31",
                            "13.105.49.120/31",
                            "13.105.49.122/31",
                            "13.105.49.124/31",
                            "13.105.49.126/31",
                            "13.105.49.128/31",
                            "13.105.49.130/31",
                            "13.105.49.132/31",
                            "13.105.49.134/31",
                            "13.105.49.136/31",
                            "13.105.49.138/31",
                            "13.105.49.140/31",
                            "13.105.49.142/31",
                            "13.105.49.144/31",
                            "13.105.49.146/31",
                            "13.105.49.148/31",
                            "13.105.49.150/31",
                            "13.105.49.152/31",
                            "13.105.49.154/31",
                            "13.105.49.156/31",
                            "13.105.49.158/31",
                            "13.105.49.160/31",
                            "13.105.49.162/31",
                            "13.105.49.164/31",
                            "13.105.49.166/31",
                            "13.105.49.168/31",
                            "13.105.49.170/31",
                            "13.105.49.172/31",
                            "13.105.49.174/31",
                            "13.105.49.176/31",
                            "13.105.49.178/31",
                            "13.105.49.180/31",
                            "13.105.49.182/31",
                            "13.105.49.184/31",
                            "13.105.49.186/31",
                            "13.105.49.188/31",
                            "13.105.49.190/31",
                            "13.105.49.192/31"
                           ]
      security_group_id  = aws_security_group.example.id
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