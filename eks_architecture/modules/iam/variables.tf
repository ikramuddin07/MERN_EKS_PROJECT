variable "cluster-name" {
  description = "The name of the EKS Cluster"
  type        = string
}

variable "is_eks_role_enabled" {
  description = "Flag to enable EKS cluster IAM role"
  type        = bool
  default     = true
}

variable "is_eks_nodegroup_role_enabled" {
  description = "Flag to enable EKS nodegroup IAM role"
  type        = bool
  default     = true
}