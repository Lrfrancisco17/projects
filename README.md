Published by: Luis Francisco
Contact: lrfrancisco17@gmail.com
Social:https://www.linkedin.com/in/luisfrancisco

Infrastructure Automation: Terraform + Ansible (RHEL & Ubuntu)
This repository provides a complete, end‑to‑end automation stack that deploys:

⦁	Ansible Controller Node
⦁	RHEL 10 Managed Node
⦁	Ubuntu Managed Node

All infrastructure is created using Terraform, and all configuration, patching, and rollback operations are handled by Ansible. Each server is bootstrapped with a default ansible user, SSH keys, and passwordless sudo via cloud-init, enabling immediate automation with no manual steps.

Project Goals:

⦁	Deploy multi‑OS infrastructure automatically
⦁	Configure passwordless automation using a dedicated Ansible user
⦁	Provide a unified Ansible playbook for:
⦁	Patching RHEL & Ubuntu
⦁	Rolling back patches (OS‑specific logic)
⦁	Maintain a clean, modular, production‑ready repo structure
⦁	Support GitLab CI/CD for validation and deployment