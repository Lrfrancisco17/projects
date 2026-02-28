variable "name" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "target_port" { type = number }
variable "health_check_path" { type = string }
variable "tags" { type = map(string) }

