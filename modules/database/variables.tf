variable "environment" {
  description = "environment of infra"
    type        = string
}
variable "allocated_storage" {
  description = "allocated storage for db instance"
  type        = number
}
variable "engine" {
  description = "database engine (e.g., mysql, postgres)"
  type        = string
}
variable "engine_version" {
  description = "database engine version"
  type        = string
}
variable "db_instance_class" {
  description = "database instance class (e.g., db.t3.micro)"
  type        = string
}
variable "private_subnet_ids" {
  description = "list of private subnet IDs for the database"
  type        = list(string)
}
variable "db_sg_id" {
  description = "security group ID for the database"
  type        = string
}
variable "kms_key_id" {
  description = "KMS key ID for encrypting database storage (optional)"
  type        = string
  default     = null
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
