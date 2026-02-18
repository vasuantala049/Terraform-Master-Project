resource "aws_kms_key" "infra_key" {
    count = var.enable_kms ? 1 : 0
    description             = "KMS key for encrypting "
  
    enable_key_rotation     = true
    
    tags = {
        Name        = "${var.environment}-infra-kms-key"
        Environment = var.environment
    }
}
resource "aws_kms_alias" "infra_key_alias" {
  count         = var.enable_kms ? 1 : 0
  name          = "alias/${var.environment}-infra-key"
  target_key_id = aws_kms_key.infra_key[0].key_id
}
