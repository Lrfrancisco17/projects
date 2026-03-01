# VPC module    

Overview  
Creates the core networking layer for the environment. It provisions a VPC, public and private subnets across multiple Availability Zones, an Internet Gateway, a NAT Gateway, and routing tables.  

What it includes  
  * VPC with DNS support  

  * Public and private subnets  

  * Internet Gateway and NAT Gateway  

  * Public and private route tables  

  * Subnet associations  

Inputs  
  
  * vpc_cidr  

  * public_subnets  

  * private_subnets  

  * azs  

  * tags  

Outputs  
  * vpc_id  

  * public_subnet_ids  

  * private_subnet_ids  
