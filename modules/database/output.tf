output "db_endpoint" {
  description = "RDS endpoint address"
  value       = aws_db_instance.db_instance.endpoint
}

output "db_instance_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.db_instance.id
}
output "db_port" {
  description = "RDS port"
  value       = aws_db_instance.db_instance.port
}
