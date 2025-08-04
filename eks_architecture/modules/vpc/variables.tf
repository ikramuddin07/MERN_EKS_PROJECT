variable "vpc_name" {
  description = "Name of the VPC"
  type        = string

}

variable "vpc_cidr" {
  description = "CIDR Block to be set for the VPC"
  type        = string
}

variable "private_subnets" {
  description = "Map of private subnet names to AZ index"
  type        = map(number)
}

variable "public_subnets" {
  description = "Map of public subnet names to AZ index"
  type        = map(number)
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "nat_eip_name" {
  description = "Name of the Elastic IP associated with the NAT gateway"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway deployed"
  type        = string
}