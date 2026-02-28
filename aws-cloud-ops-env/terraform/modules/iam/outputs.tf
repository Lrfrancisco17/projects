output "bastion_instance_profile" {
  value = aws_iam_instance_profile.bastion.name
}

output "app_instance_profile" {
  value = aws_iam_instance_profile.app.name
}

