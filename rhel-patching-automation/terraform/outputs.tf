output "controller_public_ip" {
  value = module.controller.public_ip
}

output "inventory" {
  value = <<EOF
[controller]
${module.controller.private_ip}

[rhel]
${module.rhel10.private_ip}

[ubuntu]
${module.ubuntu.private_ip}

[all:vars]
ansible_user=ansible
EOF
}

