output "eks_cluster_role_arn" {
  description = "ARN of the IAM role used by EKS Cluster"
  value       = aws_iam_role.eks-cluster-role[0].arn
}

output "eks_node_role_arn" {
  description = "ARN of the IAM role used by EKS Node Groups"
  value       = aws_iam_role.eks-nodegroup-role[0].arn
}