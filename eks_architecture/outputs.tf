# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.mern_vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.mern_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.mern_vpc.private_subnet_ids
}

# Jump Server Outputs
output "jump_server_instance_id" {
  description = "Jump server instance ID"
  value       = module.jump_ec2.instance_id
}

output "jump_server_public_ip" {
  description = "Jump server public IP"
  value       = module.jump_ec2.public_ip
}

output "jump_server_private_ip" {
  description = "Jump server private IP"
  value       = module.jump_ec2.private_ip
}

# Security Group Outputs
output "jump_server_security_group_id" {
  description = "Jump server security group ID"
  value       = module.security_groups.basic_sg_id
}

# EKS Cluster Outputs
output "eks_cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "eks_cluster_arn" {
  description = "EKS cluster ARN"
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_version" {
  description = "EKS cluster version"
  value       = module.eks.cluster_version
}

output "eks_cluster_oidc_issuer_url" {
  description = "EKS cluster OIDC issuer URL"
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_cluster_oidc_provider_arn" {
  description = "EKS cluster OIDC provider ARN"
  value       = module.eks.cluster_oidc_provider_arn
}

output "eks_cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = module.eks.cluster_security_group_id
}

# EKS Node Groups Outputs
output "eks_ondemand_nodegroup_arn" {
  description = "On-demand node group ARN"
  value       = module.eks.nodegroup_ondemand_arn
}

output "eks_spot_nodegroup_arn" {
  description = "Spot node group ARN"
  value       = module.eks.nodegroup_spot_arn
}

# IAM Outputs
output "eks_cluster_role_arn" {
  description = "EKS cluster IAM role ARN"
  value       = module.iam.eks_cluster_role_arn
}

output "eks_nodegroup_role_arn" {
  description = "EKS node group IAM role ARN"
  value       = module.iam.eks_node_role_arn
}

# EKS Data Outputs
output "eks_cluster_certificate_authority_data" {
  description = "EKS cluster certificate authority data"
  value       = module.eks_data.cluster_certificate_authority_data
}

output "eks_cluster_auth_token" {
  description = "EKS cluster authentication token"
  value       = module.eks_data.cluster_auth_token
  sensitive   = true
}

output "eks_node_groups" {
  description = "EKS node group names"
  value       = module.eks_data.node_groups
}

output "eks_addon_arns" {
  description = "EKS addon ARNs"
  value       = module.eks_data.addon_arns
}