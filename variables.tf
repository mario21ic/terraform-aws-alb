variable "region" {
  description = "aws region"
}

variable "name" {
  description = "ELB name"
}

variable "env" {
  description = "Environment name"
}

variable "internal" {
  default = false
}

variable "health_check_path" {}

variable "vpc_id" {
  description = "VPC Id"
}

variable "subnet_ids" {
  type = "list"
  description = "Subnet available"
}