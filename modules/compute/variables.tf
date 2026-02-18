variable "environment" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "app_sg_id" {
  type = string
}

variable "instance_profile_name" {
  type = string
}
