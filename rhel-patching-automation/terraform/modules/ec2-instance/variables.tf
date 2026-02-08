variable "ami" { type = string }
variable "instance_type" { type = string }
variable "subnet_id" { type = string }
variable "security_groups" { type = list(string) }
variable "cloud_init" { type = string }
variable "tags" { type = map(string) }

