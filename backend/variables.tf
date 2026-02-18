variable "backend_bucket_name" {
  description = "The name of the S3 bucket to store Terraform state files."
  type        = string
  default = "terraform-multi-env-infra-project-backend-bucket"
  
}