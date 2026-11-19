output "eks_cluster_role_arn" {
  description = "IAM role ARN used by the EKS cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "IAM role ARN used by the EKS node group"
  value       = aws_iam_role.eks_node_role.arn
}