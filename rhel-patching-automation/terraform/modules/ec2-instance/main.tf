resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups

  user_data = templatefile(var.cloud_init, {
    ssh_pubkey = file(var.ssh_pubkey_path)
  })

  tags = var.tags
}

