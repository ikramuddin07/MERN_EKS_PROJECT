output "eks_cluster_role_arn" {
  description = "ARN of the IAM role used by EKS Cluster"
  value       = aws_iam_role.eks-cluster-role[0].arn
}

output "eks_nodegroup_role_arn" {
  description = "ARN of the IAM role used by EKS Node Groups"
  value       = aws_iam_role.eks-nodegroup-role[0].arn
}

output "eks_oidc_role_name" {
  description = "Name of the IAM role for OIDC"
  value       = aws_iam_role.eks_oidc.name
}

output "eks_oidc_policy_arn" {
  description = "ARN of the policy attached to OIDC role"
  value       = aws_iam_policy.eks-oidc-policy.arn
}