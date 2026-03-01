# EC2 (Bastion) module  

Overview  

Deploys a bastion host used for secure access into the private network using AWS Systems Manager Session Manager.  

What it includes  

 * EC2 instance in a public subnet  

 * Security group allowing SSH only from approved CIDRs  

 * IAM instance profile for SSM access  

Inputs  
 * ami_id  

 * instance_type  

 * public_subnet_id  

 * vpc_id  

 * allowed_ssh_cidrs  

 * instance_profile  

 * tags  

Outputs  

 * bastion_id
