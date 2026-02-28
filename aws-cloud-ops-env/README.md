
A full AWS Cloud Operations environment using Terraform, fully automated, with chaos‑tested.


This environment provisions:  

Multi‑AZ VPC - A VPC with publiic and private subnets across two Availability Zones.   
ALB + ASG running a Flask app - An Application Load Balancer distributing traffic to a private Auto Scaling Group.  
Bastion via SSM - A bastion host for secure access using SSM.  
CloudWatch dashboards + alarms  
SNS alerts - CloudWatch dashboards, alarms, and SNS notifications.  
Chaos engineered bash scripts  
Clean, modular Terraform across all components  


This project showcases the core of CloudOps/SRE work: automation, monitoring, resilience, and real‑world troubleshooting.



Repository structure  

aws-cloud-ops-env/  
├── ansible/                 # Optional configuration management  
│   ├── playbooks/  
│   └── roles/  
├── app/  
│   └── simple-web-app/      # Sample application  
├── chaos/                   # Failure injection scripts  
│   ├── break-network.sh  
│   ├── fill-disk.sh  
│   └── kill-nginx.sh  
├── remediation/             # Lambda self-healing functions  
│   ├── lambda_replace_instance/  
│   └── lambda_restart_instance/  
└── terraform/  
    ├── envs/  
    │   ├── dev/             # Dev environment  
    │   └── prod/            # Prod environment (future)  
    ├── modules/             # Reusable Terraform modules  
    │   ├── alb/  
    │   ├── asg/  
    │   ├── ec2/  
    │   ├── iam/  
    │   ├── monitoring/  
    │   └── vpc/  
    ├── main.tf  
    ├── variables.tf  
    └── outputs.tf  

Features  
Multi‑tier AWS architecture  
VPC with public/private subnets, NAT gateway, and routing.  

Bastion host for secure access using SSM Session Manager.  

ALB routing traffic to private EC2 instances in an Auto Scaling Group.  

Automated provisioning with Terraform  
Modular design for VPC, ALB, ASG, EC2, IAM, and monitoring.  

Remote state stored in S3 with DynamoDB locking.  

Environment‑specific configuration (dev, prod).  

Application deployment  
Cloud‑init user data installs and runs a Python Flask app.  

Health check endpoint (/healthz) integrated with ALB.  

Monitoring and observability  
CloudWatch dashboard for CPU, ALB metrics, and ASG health.  

CloudWatch alarms for high CPU and unhealthy hosts.  

SNS topic for alert notifications.  

Self‑healing automation (in progress)  
EventBridge rules to detect failures.  

Lambda functions to restart or replace unhealthy instances.  

Chaos engineering toolkit  
Scripts to simulate real operational failures:  

Kill the application process.  

Fill disk space.  

Break outbound network connectivity.  

Each script includes expected symptoms and recovery behavior.  

Deployment instructions  
Prerequisites  
AWS CLI configured with appropriate credentials.  

Terraform v1.5+ installed.  

S3 bucket and DynamoDB table create manually (one time)  

Create S3 bucket command:  

aws s3api create-bucket \  
  --bucket aws-cloud-ops-lab-tfstate-dev \  
  --region us-east-1  



Create DynamoDB table command:

aws dynamodb create-table \  
  --table-name aws-cloud-ops-lab-tf-locks \  
  --attribute-definitions AttributeName=LockID,AttributeType=S \  
  --key-schema AttributeName=LockID,KeyType=HASH \  
  --billing-mode PAY_PER_REQUEST  


Initialize Terraform backend  

  #cd terraform/envs/dev  
  #terraform init  

Validate configuration  

  #terraform validate  


Deploy the environment  

  #terraform apply  

Terraform will provision the full environment, including VPC, ALB, ASG, bastion, IAM roles, monitoring, and SNS.  

Accessing the environment  
Application  
After deployment, Terraform outputs the Application Load Balancer (ALB) DNS name:  

alb_dns = <value>  
Visit:  


http://<alb_dns>  
Bastion host  
The bastion is configured for SSM Session Manager:  

aws ssm start-session --target <bastion_instance_id>  
No SSH keys required.  

Chaos engineering scenarios  
Located in the chaos/ directory.  

Each script includes:  

What failure it simulates.  

Expected CloudWatch metrics and alarms.  

Expected remediation behavior.  

Manual recovery steps.  

Example:  

  #./kill-nginx.sh  
This stops the app service, causing ALB health checks to fail and triggering alarms.  
 
