output "basic_sg_id" {
  value = aws_security_group.basic_sg.id
}

output "eks_cluster_sg_id" {
  value = aws_security_group.eks_cluster_sg.id
}