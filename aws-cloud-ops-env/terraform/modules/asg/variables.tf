variable "name" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "instance_profile" { type = string }
variable "user_data" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "alb_sg_id" { type = string }
variable "target_group_arn" { type = string }
variable "app_port" { type = number }
variable "min_size" { type = number }
variable "max_size" { type = number }
variable "desired_capacity" { type = number }
variable "tags" { type = map(string) }

