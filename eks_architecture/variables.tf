variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "default_region" {
  description = "Default Region"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets and AZ indexes"
  type        = map(number)
  default = {
    "public_subnet_1" = 0
    "public_subnet_2" = 1
    "public_subnet_3" = 2
  }
}

variable "private_subnets" {
  description = "Map of private subnets and AZ indexes"
  type        = map(number)
  default = {
    "private_subnet_1" = 0
    "private_subnet_2" = 1
    "private_subnet_3" = 2
  }
}

variable "igw_name" {
  description = "Internet Gateway name"
  type        = string
}

variable "nat_eip_name" {
  description = "Elastic IP name for NAT gateway"
  type        = string
}

variable "nat_gateway_name" {
  description = "NAT Gateway name"
  type        = string
}

variable "instance_type" {
  description = "Type of the Instance to be used"
  type        = string
}

variable "root_volume_size" {
  description = "Size of root volume"
  type        = number
}

variable "root_volume_type" {
  description = "Type of root volume"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 Instance"
  type        = string
}

variable "availability_zone" {
  description = "AZ for the EC2 Instance"
  type        = string
}

variable "sg_name" {
  description = "Name of the security Group"
  type        = string
}

# Variables for eks
# variables.tf for Root Module

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.29"
}

variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "ondemand_instance_types" {
  description = "List of instance types for the On-Demand node group"
  type        = list(string)
}

variable "spot_instance_types" {
  description = "List of instance types for the Spot node group"
  type        = list(string)
}

variable "desired_capacity_on_demand" {
  description = "Desired number of instances in the On-Demand node group"
  type        = number
}

variable "min_capacity_on_demand" {
  description = "Minimum number of instances in the On-Demand node group"
  type        = number
}

variable "max_capacity_on_demand" {
  description = "Maximum number of instances in the On-Demand node group"
  type        = number
}

variable "desired_capacity_spot" {
  description = "Desired number of instances in the Spot node group"
  type        = number
}

variable "min_capacity_spot" {
  description = "Minimum number of instances in the Spot node group"
  type        = number
}

variable "max_capacity_spot" {
  description = "Maximum number of instances in the Spot node group"
  type        = number
}

variable "eks_addons" {
  description = "List of EKS addons with name and version"
  type = list(object({
    name    = string
    version = string
  }))
}

variable "cidr_ipv4" {
  description = "IP from which the resource is allowed to be connected from"
  type = string
}