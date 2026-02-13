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
