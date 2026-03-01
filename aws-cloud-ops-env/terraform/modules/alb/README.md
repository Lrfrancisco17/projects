# ALB module

Overview  
Deploys an Application Load Balancer that routes HTTP traffic to a target group. Includes a security group, listener, and health checks.  

What it includes  
 * ALB in public subnets  

 * Security group allowing inbound HTTP  

 * Target group with health checks  

 * HTTP listener forwarding to the target group  

Inputs  

 * vpc_id  

 * public_subnet_ids  

 * target_port  

 * health_check_path  

 * tags  

Outputs

 * alb_dns  

 * target_group_arn  

 * alb_sg_id
