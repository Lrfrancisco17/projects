# --------------------------------------------------
# EC2 Instance
# --------------------------------------------------
resource "aws_instance" "this" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = var.security_groups

  user_data = templatefile(var.cloud_init, {
    ssh_pubkey = var.ssh_pubkey_path != null ? file(var.ssh_pubkey_path) : ""
  })

  tags = var.tags

  # --------------------------------------------------
  # Connection used by all provisioners in this resource
  # --------------------------------------------------
  connection {
    type        = "ssh"
    user        = "ansible"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  # --------------------------------------------------
  # Copy your personal SSH key
  # --------------------------------------------------
  provisioner "file" {
    source      = "~/.ssh/id_rsa"
    destination = "/home/ansible/.ssh/id_rsa"
  }

  provisioner "file" {
    source      = "~/.ssh/id_rsa.pub"
    destination = "/home/ansible/.ssh/id_rsa.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/ansible/.ssh/id_rsa",
      "chmod 644 /home/ansible/.ssh/id_rsa.pub",
      "chown ansible:ansible /home/ansible/.ssh/id_rsa*"
    ]
  }
}

# --------------------------------------------------
# Deploy project-specific SSH key (conditional)
# --------------------------------------------------
resource "null_resource" "deploy_key" {
  count = var.deploy_key_private_path == null ? 0 : 1

  triggers = {
    instance_id = aws_instance.this.id
  }

  connection {
    type        = "ssh"
    user        = "ansible"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.this.public_ip
  }

  provisioner "file" {
    source      = var.deploy_key_private_path
    destination = "/home/ansible/.ssh/project_deploy_key"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/ansible/.ssh/project_deploy_key",
      "chown ansible:ansible /home/ansible/.ssh/project_deploy_key",
      
      # Make sure GitHub is trusted
      "ssh-keyscan github.com >> /home/ansible/.ssh/known_hosts",

      # Clone the repo using the deploy key
      "GIT_SSH_COMMAND='ssh -i /home/ansible/.ssh/project_deploy_key -o StrictHostKeyChecking=no' git clone ${var.repo_url} /home/ansible/project",

      # Fix permissions
      "chown -R ansible:ansible /home/ansible/project"
    ]
  }
}

