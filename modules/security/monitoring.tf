resource "aws_cloudwatch_log_group" "security_logs" {
    count = var.enable_cloudtrail ? 1 : 0
  name  = "/${var.environment}/security"
  retention_in_days = 7
  tags = {
    Environment = var.environment
  }
}
resource "aws_s3_bucket" "cloudtrail_bucket" {
  count = var.enable_cloudtrail ? 1 : 0
  bucket = "${var.environment}-cloudtrail-logs-${random_id.bucket_suffix[count.index].hex}"
  force_destroy = true
    
  tags = {
    Environment = var.environment
  }
  
}
resource "random_id" "bucket_suffix" {
    count = var.enable_cloudtrail ? 1 : 0
  byte_length = 7
}
resource "aws_cloudtrail" "cloudtrail" {
  count = var.enable_cloudtrail ? 1 : 0
  name = "${var.environment}-cloudtrail"
  depends_on = [ aws_s3_bucket_policy.cloudtrail_bucket_policy ]
  s3_bucket_name = aws_s3_bucket.cloudtrail_bucket[count.index].id
  include_global_service_events = true
  is_multi_region_trail = true
    enable_log_file_validation = true
    enable_logging = true
    cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.security_logs[count.index].arn}:*"
    cloud_watch_logs_role_arn = aws_iam_role.cloudtrail_role[count.index].arn

  tags = {
    Environment = var.environment
  }
}
resource "aws_iam_role" "cloudtrail_role" {
        count = var.enable_cloudtrail ? 1 : 0
  name = "${var.environment}-cloudtrail-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy" "cloudtrail_logs_policy" {
  count = var.enable_cloudtrail ? 1 : 0

  name = "${var.environment}-cloudtrail-logs-policy"
  role = aws_iam_role.cloudtrail_role[count.index].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.security_logs[count.index].arn}:*"
      }
    ]
  })
}

resource "aws_guardduty_detector" "guardduty" {
  count = var.enable_guardduty ? 1 : 0
  enable = true
}
resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  count = var.enable_cloudtrail ? 1 : 0
  bucket = aws_s3_bucket.cloudtrail_bucket[count.index].id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.cloudtrail_bucket[count.index].arn
      },
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.cloudtrail_bucket[count.index].arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
  
}
data "aws_caller_identity" "current" {
  
}
