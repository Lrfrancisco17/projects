variable "name" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "public_subnet_id" { type = string }
variable "vpc_id" { type = string }
variable "allowed_ssh_cidrs" { type = list(string) }
variable "instance_profile" { type = string }
variable "tags" { type = map(string) }

