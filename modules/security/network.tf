resource "aws_security_group" "alb_sg" {
  name        = "${var.environment}-alb-sg"
  description = "Security group for ALB in ${var.environment} environment"
  vpc_id      = var.vpc_id


    tags = {
      Name = "${var.environment}-alb-sg"
        Environment = var.environment
    }
}
resource "aws_security_group" "app_sg" {
  name        = "${var.environment}-app-sg"
  description = "Security group for application servers in ${var.environment} environment"
  vpc_id      = var.vpc_id

 
    tags = {
      Name = "${var.environment}-app-sg"
        Environment = var.environment
    }

  
}
resource "aws_security_group" "db_sg" {
  name        = "${var.environment}-db-sg"
  description = "Security group for database servers in ${var.environment} environment"
  vpc_id      = var.vpc_id 

    tags = {
      Name = "${var.environment}-db-sg"
        Environment = var.environment
    }
}
resource "aws_security_group_rule" "alb_to_app" {
  type                     = "ingress"
  from_port                = var.app_port
  to_port                  = var.app_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}
resource "aws_security_group_rule" "app_to_db" {
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db_sg.id
  source_security_group_id = aws_security_group.app_sg.id
}
resource "aws_security_group_rule" "public_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = aws_security_group.alb_sg.id
}
resource "aws_security_group_rule" "public_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = aws_security_group.alb_sg.id
}