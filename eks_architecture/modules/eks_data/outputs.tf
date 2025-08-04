output "tls_certificate_sha1_fingerprint" {
  description = "SHA1 fingerprint of the EKS cluster TLS certificate"
  value       = data.tls_certificate.eks-certificate.certificates[0].sha1_fingerprint
}

output "tls_certificate_url" {
  description = "URL of the EKS cluster TLS certificate"
  value       = data.tls_certificate.eks-certificate.url
}

output "oidc_assume_role_policy_json" {
  description = "JSON policy document for OIDC assume role"
  value       = data.aws_iam_policy_document.eks_oidc_assume_role_policy.json
}

output "cluster_id" {
  description = "EKS cluster ID"
  value       = data.aws_eks_cluster.cluster.id
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = data.aws_eks_cluster.cluster.arn
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = data.aws_eks_cluster.cluster.endpoint
}

output "cluster_certificate_authority_data" {
  description = "EKS cluster certificate authority data"
  value       = data.aws_eks_cluster.cluster.certificate_authority[0].data
}

output "cluster_auth_token" {
  description = "EKS cluster authentication token"
  value       = data.aws_eks_cluster_auth.cluster.token
}

output "node_groups" {
  description = "List of EKS node group names"
  value       = data.aws_eks_node_groups.all.names
}

output "addon_arns" {
  description = "Map of addon names to their ARNs"
  value       = { for k, v in data.aws_eks_addon.addons : k => v.arn }
} 