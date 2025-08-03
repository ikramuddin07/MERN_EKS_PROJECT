output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "EKS Cluster Certificate Authority Data"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_security_group_id" {
  description = "Security Group ID of the EKS Cluster"
  value       = module.eks.cluster_security_group_id
}

output "node_group_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  value       = module.iam.node_group_role_arn
}

output "cluster_oidc_provider_arn" {
  description = "OIDC provider ARN for EKS"
  value       = module.iam.oidc_provider_arn
}

output "on_demand_node_group_name" {
  description = "On-Demand Node Group Name"
  value       = module.eks_node_group_on_demand.node_group_name
}

output "spot_node_group_name" {
  description = "Spot Node Group Name"
  value       = module.eks_node_group_spot.node_group_name
}