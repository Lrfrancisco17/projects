terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "lab"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "tags" {
  type = map(string)
  default = {
    Name = "rhel10-t3-micro"
    Env  = "lab"
  }
}

data "aws_ami" "rhel10" {
  most_recent = true
  owners      = ["309956199498"]

  filter {
    name   = "name"
    values = ["RHEL-10*"]
  }
}

resource "aws_instance" "rhel10_t3_micro" {
  ami           = data.aws_ami.rhel10.id
  instance_type = var.instance_type
  tags          = var.tags
}

output "instance_public_ip" {
  value = aws_instance.rhel10_t3_micro.public_ip
}
