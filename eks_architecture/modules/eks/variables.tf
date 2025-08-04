variable "is-eks-cluster-enabled" {
  type    = bool
  default = true
}

variable "cluster-name" {
  type = string
}

variable "cluster-version" {
  type    = string
  default = "1.29"
}

variable "endpoint-private-access" {
  type    = bool
  default = false
}

variable "endpoint-public-access" {
  type    = bool
  default = true
}

variable "env" {
  type = string
}

variable "ondemand_instance_types" {
  type = list(string)
}

variable "spot_instance_types" {
  type = list(string)
}

variable "desired_capacity_on_demand" {
  type = number
}

variable "min_capacity_on_demand" {
  type = number
}

variable "max_capacity_on_demand" {
  type = number
}

variable "desired_capacity_spot" {
  type = number
}

variable "min_capacity_spot" {
  type = number
}

variable "max_capacity_spot" {
  type = number
}

variable "addons" {
  description = "List of EKS addons with name and version"
  type = list(object({
    name    = string
    version = string
  }))
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for EKS cluster"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for EKS cluster"
  type        = string
}

variable "eks_cluster_role_arn" {
  description = "ARN of the IAM role for EKS cluster"
  type        = string
}

variable "eks_nodegroup_role_arn" {
  description = "ARN of the IAM role for EKS node groups"
  type        = string
}

variable "security_group_ids" {
  description = "Security Group for the EKS Cluster"
  type        = list(string)
}