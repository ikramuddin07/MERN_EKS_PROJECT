resource "aws_iam_role" "eks_cluster_role" {
  name = var.role_name
  assume_role_policy = jsondecode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid = ""
            Principal = {
                Service = "eks.amazonaws.com"
            }
        }
    ]
  })

  tags = {
    Name = var.eks_role_name
  }
}