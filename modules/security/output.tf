output "kms_key_arn" {
  value       = var.enable_kms ? aws_kms_key.infra_key[0].arn : null
  description = "KMS key ARN for encryption"
}

output "kms_key_id" {
  value       = var.enable_kms ? aws_kms_key.infra_key[0].key_id : null
  description = "KMS key ID"
}
output "db_username" {
  value = jsondecode(aws_secretsmanager_secret_version.initial_db_secrets.secret_string)["username"]
}

output "db_password" {
  value     = jsondecode(aws_secretsmanager_secret_version.initial_db_secrets.secret_string)["password"]
  sensitive = true
}

output "db_secret_arn" {
  value       =  aws_secretsmanager_secret.db_secret.arn
  description = "ARN of database secret"
}
output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "Security group ID for ALB"
}

output "app_sg_id" {
  value       = aws_security_group.app_sg.id
  description = "Security group ID for application servers"
}

output "db_sg_id" {
  value       = aws_security_group.db_sg.id
  description = "Security group ID for database"
}
output "ec2_instance_profile_name" {
  value       = aws_iam_instance_profile.ec2_instance_profile.name
  description = "Instance profile name for EC2"
}
