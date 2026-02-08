
Infrastructure Automation Project: 

Terraform + Ansible (RHEL & Ubuntu)
This repository provides a complete, end‑to‑end automation stack that deploys:

*	Ansible Controller Node
*	RHEL 10 Managed Node
*	Ubuntu Managed Node

All infrastructure is created using Terraform, and all configuration, patching, and rollback operations are handled by Ansible. Each server is bootstrapped with a default Ansible user, SSH keys, and passwordless sudo via cloud-init, enabling immediate automation with no manual steps.

Project Goals:

*	Deploy multi‑OS infrastructure automatically
*	Configure passwordless automation using a dedicated Ansible user
*	Provide a unified Ansible playbook for Patching RHEL & Ubuntu
*	Rolling back patches (OS‑specific logic)
*	Maintain a clean, modular, production‑ready repo structure
*	Support GitLab CI/CD for validation and deployment


---- Prerequisites ----
Before using this lab, ensure you have:

Terraform ≥ 1.5
Ansible ≥ 2.15
AWS CLI configured with a profile (default: lab)
SSH key pair at ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub

If you need to generate a key:

#ssh-keygen -t rsa -b 4096


---- Deploying the Infrastructure ----

Navigate into the Terraform directory:  

#cd terraform-ansible-lab/terraform

1. Initialize Terraform  

#terraform init

2. Review the plan

terraform plan

3. Deploy the environment

terraform apply -auto-approve

Terraform will create:  

* VPC, subnet, route table, IGW
* Security group for SSH
* Controller EC2 instance
* RHEL 10 EC2 instance
* Ubuntu EC2 instance

command
terraform init
terraform apply -auto-approve
terraform output inventory > ../ansible/inventory.ini


  
Published by: Luis Francisco  
Contact: lrfrancisco17@gmail.com  
Social: https://www.linkedin.com/in/luisfrancisco  
Certifications: https://www.credly.com/users/luisfrancisco  
Youtube: https://www.youtube.com/@Innovationlu  
