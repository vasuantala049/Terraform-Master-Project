variable "environment" {
  description = "environment of storage infra"
  type = string
}
variable "kms_key_id" {
  description = "KMS key ID for S3 bucket encryption"
  type = string
  default = null
}