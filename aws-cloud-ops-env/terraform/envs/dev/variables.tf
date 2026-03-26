############################################
# REGION & NETWORKING
############################################

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

############################################
# BASTION HOST
############################################

variable "bastion_ami" {
  type    = string
  default = "ami-0c02fb55956c7d316" # Amazon Linux 2
}

variable "bastion_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "allowed_ssh_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

############################################
# APP TIER (ASG)
############################################

# Lookup Amazon Linux 2023 AMI dynamically
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

variable "app_instance_type" {
  type    = string
  default = "t3.micro"
}

