    variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
    }
    variable "app_port" {
    description = "The port for the application servers"
    type        = number

    }
    variable "db_port" {
    description = "The port for the database servers"
    type        = number
    }
    variable "allowed_cidr_blocks" {
    description = "allowed cidrs to alb"
        type        = list(string)
    }
    variable "environment" {
    description = "env"
        type        = string
    }

    variable "enable_kms" {
  description = "Enable custom KMS key creation"
  type        = bool
  default     = false
}


variable "db_username" {
  type        = string
  description = "Database master username"
  default     = "admin"
}
variable "enable_cloudtrail" {
  type = bool
  description = "enable cloudtrail"
  default = false
}
variable "enable_guardduty" {
  type = bool
  description = "enable guardduty"
  default = false
  
}

