resource "aws_secretsmanager_secret" "db_secret" {
 
  name = "${var.environment}-db-secret"
  description = "Database credentials for ${var.environment} environment"
  kms_key_id = var.enable_kms? aws_kms_key.infra_key[0].arn:null
   tags = {
    Name        = "${var.environment}-db-secret"
    Environment = var.environment
  }
}
resource "random_password" "db_password" {
 
  length = 16
 special = false
}
resource "aws_secretsmanager_secret_version" "initial_db_secrets" {
 
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
  })
}