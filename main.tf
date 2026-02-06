#terraform {
#  required_version = ">= 1.5.0"

#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "~> 5.0"
#    }
#  }
#}

provider "aws" {
  region = "us-east-1"
}

# Replace this with the actual RHEL 10 AMI for your region
variable "rhel10_ami_id" {
  type        = string
  description = "RHEL 10 AMI ID"
  default     = "ami-0ad50334604831820"
}

resource "aws_instance" "rhel10_t3_micro" {
  ami           = var.rhel10_ami_id
  instance_type = "t3.micro"

  tags = {
    Name = "rhel10-t3-micro"
    Env  = "lab"
  }
}