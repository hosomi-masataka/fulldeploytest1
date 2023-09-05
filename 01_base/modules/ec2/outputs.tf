output "ec2_step_public_ip" {
  value = aws_instance.ec2_step.public_ip
}

output "ec2_instance_id_step" {
  value = aws_instance.ec2_step.id
}

output "ec2_instance_id_private01" {
  value = aws_instance.ec2_private01.id
}
