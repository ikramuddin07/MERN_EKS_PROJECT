# TLS Certificate for EKS OIDC
data "tls_certificate" "eks-certificate" {
  url = var.cluster_oidc_issuer_url
}

# OIDC Assume Role Policy Document
data "aws_iam_policy_document" "eks_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_oidc_issuer_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:aws-test"]
    }

    principals {
      identifiers = [var.cluster_oidc_provider_arn]
      type        = "Federated"
    }
  }
}

# EKS Cluster Data
data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

# EKS Cluster Auth Data
data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

# Get EKS Node Groups
data "aws_eks_node_groups" "all" {
  cluster_name = var.cluster_name
}

# Get EKS Addons
data "aws_eks_addon" "addons" {
  for_each     = toset(var.cluster_addons)
  cluster_name = var.cluster_name
  addon_name   = each.value
}