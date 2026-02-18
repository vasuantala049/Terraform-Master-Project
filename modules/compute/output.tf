output "instance_id" {
  value = aws_instance.ec2_instances[*].id
}

output "private_ip" {
  value = aws_instance.ec2_instances[*].private_ip
}


