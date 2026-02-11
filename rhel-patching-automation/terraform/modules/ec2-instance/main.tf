resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups

  user_data = templatefile(var.cloud_init, {
    ssh_pubkey = var.ssh_pubkey_path != null ? file(var.ssh_pubkey_path) : ""
  })

  tags = var.tags

  connection {
    type        = "ssh"
    user        = "ansible"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

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

