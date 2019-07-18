variable "region" {
  description = "aws region"
}

variable "name" {
  description = "ELB name"
}

variable "env" {
  description = "Environment name"
}

variable "timeout" {
  default = 60
}

variable "internal" {
  default = false
}

variable "ssl_qty" {
  default = 0
}

variable "ssl_arns" {
  type    = "list"
  default = []
}

variable "ssl_extras_qty" {
  default = 0
}

variable "ssl_extras_arns" {
  type    = "list"
  default = []
}

variable "health_check_path" {}

variable "target_group_qty" {
  default = 0
}

variable "target_group_arns" {
  type    = "list"
  default = []
}

variable "vpc_id" {
  description = "VPC Id"
}

variable "security_group_ids" {
  type = "list"
}

variable "subnet_ids" {
  type        = "list"
  description = "Subnet available"
}
