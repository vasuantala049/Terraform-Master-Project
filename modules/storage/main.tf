resource "aws_s3_bucket" "storage_bucket" {
  bucket = "${var.environment}-storage-bucket-${random_id.bucket_suffix.hex}"
 
  force_destroy = true

  tags = {
    Name        = "${var.environment}-storage-bucket"
    Environment = var.environment
  }
  
}
resource "random_id" "bucket_suffix" {
  byte_length = 7
}

resource "aws_s3_bucket_public_access_block" "storage_bucket_access_block" {
    bucket = aws_s3_bucket.storage_bucket.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_server_side_encryption_configuration" "storage_bucket_encryption" {
    bucket = aws_s3_bucket.storage_bucket.id
 rule {
    apply_server_side_encryption_by_default {
       sse_algorithm     = var.kms_key_id != null ? "aws:kms" : "AES256"
        kms_master_key_id = var.kms_key_id != null ? var.kms_key_id : null

    }
  }
}
resource "aws_s3_bucket_versioning" "storage_bucket_versioning" {
  bucket = aws_s3_bucket.storage_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}