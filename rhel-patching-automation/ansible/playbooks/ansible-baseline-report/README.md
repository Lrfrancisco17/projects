# Baseline Report Project (Ansible)  
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

  
Requirements  
Ansible 2.15+  

Python boto3 (for AWS inventory)  

AWS credentials configured locally  

SMTP credentials for sending email  

Install dependencies:  

pip install boto3 botocore  
