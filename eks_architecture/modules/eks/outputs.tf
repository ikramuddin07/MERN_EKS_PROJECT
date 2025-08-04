output "cluster_id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.eks[0].id
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.eks[0].arn
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.eks[0].endpoint
}

output "cluster_version" {
  description = "EKS cluster version"
  value       = aws_eks_cluster.eks[0].version
}

output "cluster_oidc_issuer_url" {
  description = "EKS cluster OIDC issuer URL"
  value       = aws_eks_cluster.eks[0].identity[0].oidc[0].issuer
}

output "cluster_oidc_provider_arn" {
  description = "EKS cluster OIDC provider ARN"
  value       = aws_iam_openid_connect_provider.eks-oidc.arn
}

output "cluster_oidc_provider_url" {
  description = "EKS cluster OIDC provider URL"
  value       = aws_iam_openid_connect_provider.eks-oidc.url
}

output "cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = var.security_group_ids[0]
}

output "nodegroup_ondemand_arn" {
  description = "On-demand node group ARN"
  value       = aws_eks_node_group.ondemand-node.arn
}

output "nodegroup_spot_arn" {
  description = "Spot node group ARN"
  value       = aws_eks_node_group.spot-node.arn
}