############################################
# PROVIDER
############################################
provider "aws" {
  region = var.region
}

############################################
# GLOBAL TAGS
############################################
locals {
  tags = {
    Environment = "dev"
    Project     = "aws-cloud-ops-lab"
    ManagedBy   = "Terraform"
  }
}

############################################
# VPC MODULE
############################################
module "vpc" {
  source = "../../modules/vpc"

  name            = "dev"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs

  tags = local.tags
}

############################################
# ALB MODULE
############################################
module "alb" {
  source = "../../modules/alb"

  name              = "dev"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

  target_port       = 8080
  health_check_path = "/healthz"

  tags = local.tags
}

############################################
# BASTION MODULE
############################################
module "bastion" {
  source = "../../modules/ec2"

  name              = "dev"
  ami_id            = var.bastion_ami
  instance_type     = var.bastion_instance_type
  public_subnet_id  = module.vpc.public_subnet_ids[0]
  vpc_id            = module.vpc.vpc_id
  allowed_ssh_cidrs = var.allowed_ssh_cidrs
  instance_profile  = module.iam.bastion_instance_profile

  tags = local.tags
}

############################################
# ASG MODULE (APP TIER)
############################################
module "asg" {
  source = "../../modules/asg"

  name             = "dev"
  ami_id           = var.app_ami
  instance_type    = var.app_instance_type
  instance_profile = module.iam.bastion_instance_profile
  user_data        = file("${path.module}/user_data.sh")

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  alb_sg_id        = module.alb.alb_sg_id
  target_group_arn = module.alb.target_group_arn

  app_port         = 8080
  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  tags = local.tags
}

############################################
# MONITORING MODULE
############################################
module "monitoring" {
  source = "../../modules/monitoring"

  name          = "dev"
  asg_name      = module.asg.asg_name
  region        = var.region
  sns_topic_arn = module.sns.arn
}

############################################
# OUTPUTS
############################################
output "alb_dns" {
  value = module.alb.alb_dns
}

output "bastion_id" {
  value = module.bastion.bastion_id
}

output "asg_name" {
  value = module.asg.asg_name
}

############################################
# IAM
############################################

module "iam" {
  source = "../../modules/iam"
  name   = "dev"
}

############################################
# sns
############################################

module "sns" {
  source = "../../modules/sns"
  name   = "dev"
}


