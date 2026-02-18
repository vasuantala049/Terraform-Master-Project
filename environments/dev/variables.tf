variable "environment" {
  type = string
}

variable "availability_zone_1" {
  type = string
}

variable "availability_zone_2" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "db_instance_class" {
  type = string
}

variable "allowed_cidr_blocks" {
  type = list(string)
}
variable "db_type" {
  type=string
}
variable "db_version" {
  type=string
}