# ASG module  

Overview  
Creates an Auto Scaling Group running application instances behind the ALB. Includes a launch template, security group, and scaling configuration.  

What it includes 
 
 * Launch template with AMI, instance type, and user data  

 * Security group allowing traffic from ALB  

 * Auto Scaling Group across private subnets  

 * Target group attachment  

Inputs  

 * ami_id  

 * instance_type  

 * instance_profile  

 * user_data  

 * private_subnet_ids  

 * alb_sg_id  

 * target_group_arn  

 * app_port  

 * min_size, max_size, desired_capacity  

 * tags  

Outputs  

 * asg_name  
