variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "profile" {
  type        = string
  default     = "lab"
  description = "AWS CLI profile"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Default EC2 instance type"
}

variable "ssh_ingress_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "CIDR allowed to SSH"
}

variable "ansible_ssh_pubkey_path" {
  type        = string
  default     = "/home/lrf/.ssh/id_rsa.pub"
  description = "Path to your local SSH public key"
}

