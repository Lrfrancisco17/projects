

[![Watch the video](https://github.com/Lrfrancisco17/projects/blob/main/thumnails/tf_ansible_prj.png)](https://www.youtube.com/watch?v=VoFaZ2rkyGw)


Infrastructure Automation Project: 

Terraform + AWS + Ansible (RHEL & Ubuntu)
This repository provides a complete, end‑to‑end automation stack that deploys:


*	1 RHEL 10 Ansible Controller Node  
*	1 RHEL 10 Managed Node  
*	1 Ubuntu Managed Node  



All infrastructure is created using Terraform, and all configuration, patching, and rollback operations are handled by Ansible. Each server is bootstrapped with a default Ansible user, SSH keys, and passwordless sudo via cloud-init, enabling immediate automation with no manual steps.

Project Goals:

*	Deploy multi‑OS infrastructure automatically
*	Configure passwordless automation using a dedicated Ansible user
*	Provide a unified Ansible playbook for Patching RHEL & Ubuntu
*	Rolling back patches (OS‑specific logic)
*	Maintain a clean, modular, production‑ready repo structure
*	Support Github CI/CD for validation and deployment  
  
  
############## Prerequisites ##############  
Before using this lab, ensure you have:

Terraform ≥ 1.5  
Ansible ≥ 2.15  
AWS CLI configured with a profile (default: lab)  
1. Make sure you have a personal SSH key pair  
These keys live in ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub.  

If you don’t already have them, generate a new pair:  

#ssh-keygen -t rsa -b 4096  

This creates:  
~/.ssh/id_rsa (private key)  
~/.ssh/id_rsa.pub (public key)  

2. Create a GitHub deploy key for your project  
This key will be used only by your controller node to clone your repo.  

Generate it:  
#ssh-keygen -t ed25519 -f ~/.ssh/project_deploy_key -C "deploy-key-project"

This creates:  
~/.ssh/project_deploy_key (private key)  
~/.ssh/project_deploy_key.pub (public key)  

3. Add the deploy key to your GitHub repository  
Make sure you’ve already copied my repo into your own GitHub account.  

Then:  
Open your GitHub repository
Go to Settings → Deploy keys   

Click Add deploy key   
Paste the contents of project_deploy_key.pub into the key field  

Enable Read access

Save
  

############## Deploying the Infrastructure via Terraform ##############

1. Download the project folder to your local machine  
   #curl -L https://github.com/Lrfrancisco17/projects/archive/refs/heads/main.zip -o repo.zip
unzip repo.zip "projects-main/rhel-patching-automation/*"  

This extracts only the rhel-patching-automation folder from my repo.  

2. Navigate into the Terraform directory  
   #cd projects-main/rhel-patching-automation/terraform  

3. (Optional) Update the Git repository URL  
    If you want the controller node to automatically clone your own Ansible repo with patching playbooks, update the repo_url value in:
    #vi terraform/main.tf  
    Look for this line (around line 138):

    repo_url = "https://github.com/Lrfrancisco17/projects.git"  
    Replace it with your Git repo URL if needed.  

4. Initialize Terraform  
    #terraform init  

5. Review the execution plan  
   #terraform plan  

6. Deploy the environment  
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

controller_public_ip = "XX.XX.XX.XXX"
[controller]
10.0.1.x

[rhel]
10.0.1.x

[ubuntu]
10.0.1.x

[all:vars]
ansible_user=ansible


############## Test Connectivity with Ansible ##############  

1. SSH into the controller using its public IP you received from the  terrafom output:  
     #ssh -i ~/.ssh/id_rsa ansible@<controller_public_ip>  

2. Change directory into ansible folder:    
   #cd ~/github/rhel-patching-automation/ansible  
  
3. Copy inventory output from terrraform and past it into inventory.ini  
   #vi invenory.ini  
    paste & save  

2. Run Ansible ping command:  
   #ansible-playbook /playbooks/ping.yml  
   

############## Run Patch Playbook ##############

Apply OS updates across all nodes: (This automatically handles yum updates for RHEL & apt updates for Ubuntu)  
  #ansible-playbook playbooks/patch.yml  

Run Rollback Playbook:  
  #ansible-playbook playbooks/rollback.yml  

############## Destroy the Environment ##############

When you're done:  
  #cd terraform  
  #terraform destroy -auto-approve  

##############  Issue I ran into ##############

During testing, I ran into a failure caused by how AWS assigns Availability Zones. Initially, I allowed the aws_subnet resource to select an AZ automatically. AWS ended up placing the subnet in us‑east‑1e, which does not support t3.micro instances. As a result, all EC2 instance launches failed.

To resolve this, I updated the subnet configuration to explicitly use us‑east‑1a, an Availability Zone that does support t3.micro instances. After setting the AZ manually, Terraform was able to deploy all instances successfully.

  
Published by: Luis Francisco   
Social: https://www.linkedin.com/in/luisfrancisco   
