resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.environment}-db-subnet-group"
  description = "Database subnet group for ${var.environment} environment"
  subnet_ids  = var.private_subnet_ids
}
resource "aws_db_instance" "db_instance" {
  identifier = "${var.environment}-db-instance"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  allocated_storage = var.allocated_storage
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.db_instance_class
  vpc_security_group_ids = [ var.db_sg_id ]
  apply_immediately = true
  username = var.db_username
  password = var.db_password
  skip_final_snapshot = true
  backup_retention_period = 0
  deletion_protection = false
  storage_encrypted = true
  kms_key_id = var.kms_key_id != null ? var.kms_key_id : null
  multi_az = false
  publicly_accessible = false
}
