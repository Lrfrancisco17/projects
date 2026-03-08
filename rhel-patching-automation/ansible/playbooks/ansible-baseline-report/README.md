# Baseline Report Project (Ansible)

[![Watch the video](https://github.com/Lrfrancisco17/projects/blob/main/thumnails/ans_runbook_prj.png)](hhttps://www.youtube.com/watch?v=d6E4WPumSKE&t=3s)
This project collects a small set of baseline system information from Linux servers running on AWS EC2 and sends the results as a styled HTML email. It is designed to be simple, readable, and easy to extend.  

Overview  
The playbook performs two tasks:  

Collects lightweight baseline data from each Linux host.  

Generates an HTML report using Jinja2 and emails it through an SMTP server.  

The project uses the AWS EC2 dynamic inventory plugin to automatically discover running instances.  

Data Collected  
The baseline role gathers only the essential information needed for a quick system snapshot:  

  * OS release and kernel version  

  * Uptime and last reboot  

  * Disk usage for /, /var, /boot  

  * Memory and CPU load  

  * Running services  

  * EC2 instance metadata (instance ID, type, AZ, AMI)  

  * SELinux mode  


Project Structure  

ansible-baseline-report/  
├── inventories/  
│   └── aws_ec2.yml  
├── roles/  
│   ├── baseline_collect/  
│   │   └── tasks/main.yml  
│   ├── email_report/  
│   │   ├── tasks/main.yml  
│   │   └── templates/report.html.j2  
├── group_vars/  
│   └── all.yml  
└── playbook.yml

  
Install all Python dependencies on the controller:  
  #pip3 install -r requirements.txt  


What is in requirements.txt:  
  ansible-core>=2.16.14  
  jinja2>=3.1.0  
  PyYAML>=6.0  
  cryptography>=41.0.0  
  requests>=2.31.0  
  boto3>=1.34.0  
  botocore>=1.34.0  
  passlib>=1.7.4  

Install the Ansible collection separately:

  #ansible-galaxy collection install community.general

How to create SES SMTP username & password  
1) Go to the AWS Console → SES (Simple Email Service)  
Make sure you are in the correct region (your SMTP endpoint is email-smtp.us-east-1.amazonaws.com, so use us‑east‑1).  

2) In the left menu, open:  
SMTP Settings → Create SMTP Credentials  

This opens an IAM wizard that creates a special IAM user with the correct SES permissions.  

3) Click Create SMTP credentials  
AWS will generate:  

SMTP Username (looks like a long string, not your IAM username)  

SMTP Password (also a long generated string)  

4) Download the credentials  
AWS gives you a .csv file containing:  
SMTP Username  
SMTP Password  

How to use them on your controller  
Export them before running your playbook:

  #export SMTP_USER="YOUR_SES_SMTP_USERNAME"  
  #export SMTP_PASS="YOUR_SES_SMTP_PASSWORD"  

Or store them in Ansible Vault:  
  
  smtp_user: "YOUR_SES_SMTP_USERNAME"
  smtp_pass: "YOUR_SES_SMTP_PASSWORD"


verify the mail module is available:  

  #ansible localhost -m community.general.mail -a "subject='test' to='you@example.com'"  

Then type:  

EHLO test
AUTH LOGIN
<base64 of SMTP_USER>
<base64 of SMTP_PASS>


If the credentials are correct, SES responds with:  
235 Authentication successful

Verify send and recive email on SES:  
You must verify Sender identity and Recipient identity:  

example email   
ansible-report@example.com  


Steps:  

Go to AWS SES Console → Verified Identities  
Click Verify New Email Address    

Enter:  
ansible-report@example.com  

recipent_email@doamin.com  

Click the verification links sent to each inbox  
After both are verified, your playbook will work immediately.  

