variable "vpc_id" {
  description = "VPC ID for the SG"
  type        = string
}

variable "sg_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "cidr_ipv4" {
  description = "IP through which the resource is allowed to be connected from"
  type        = string
}