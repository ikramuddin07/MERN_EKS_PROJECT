variable "vpc_id" {
  description = "VPC_ID"
  type        = string
}

variable "cidr_ipv4" {
  description = "IP which the instance is allowed to connect from"
  type        = string
}