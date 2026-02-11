
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

  

---- Deploying the Infrastructure via Terraform ----

1. Navigate into the Terraform directory:  
   #cd terraform-ansible-lab/terraform

2. Initialize Terraform  

   #terraform init

3. Review the plan

    #terraform plan

4. Deploy the environment

    #terraform apply -auto-approve
 

Terraform will create:  

* VPC, subnet, route table, IGW
* Security group for SSH
* Controller EC2 instance
* RHEL 10 EC2 instance
* Ubuntu EC2 instance

After Terraform completes, export the generated inventory: Do not skip this step!!  
terraform output inventory > ../ansible/inventory.ini

This file will look like:

[controller]
10.0.1.x

[rhel]
10.0.1.x

[ubuntu]
10.0.1.x

[all:vars]
ansible_user=ansible


---- Test Connectivity with Ansible ----  
1. SSH into the controller using its public IP you received from the  terrafom output:  
     #ssh -i ~/.ssh/id_rsa ansible@<controller_public_ip>  

2.Generate a key:  
     #ssh-keygen -t ed25519 -C "controller"  
     
3.Show the public key and copy it to repos GitHub → Settings → SSH and GPG keys → New SSH key  
     #cat ~/.ssh/id_ed25519.pub  

4.Then clone using SSH:
   #git clone git@github.com:username/projects.git


---- Run Patch Playbook ----

Apply OS updates across all nodes: (This automatically handles yum updates for RHEL & apt updates for Ubuntu)  
  #ansible-playbook playbooks/patch.yml  

Run Rollback Playbook:  
  #ansible-playbook playbooks/rollback.yml  

--- Destroy the Environment ---

When you're done:  
  #cd terraform  
  #terraform destroy -auto-approve  

---   Issue I ran into ---

During testing, I ran into a failure caused by how AWS assigns Availability Zones. Initially, I allowed the aws_subnet resource to select an AZ automatically. AWS ended up placing the subnet in us‑east‑1e, which does not support t3.micro instances. As a result, all EC2 instance launches failed.

To resolve this, I updated the subnet configuration to explicitly use us‑east‑1a, an Availability Zone that does support t3.micro instances. After setting the AZ manually, Terraform was able to deploy all instances successfully.

  
Published by: Luis Francisco   
Social: https://www.linkedin.com/in/luisfrancisco   
