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
  default = ["0.0.0.0/0"] # Replace with your IP
}

variable "app_ami" {
  type    = string
  default = "ami-0c02fb55956c7d316"
}

variable "app_instance_type" {
  type    = string
  default = "t3.micro"
}

