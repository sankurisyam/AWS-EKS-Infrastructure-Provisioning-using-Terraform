output "environment" {
  description = "Deployment environment"
  value       = var.environment
}

output "vpc_id" {
  description = "EKS VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs used by EKS"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "eks_node_role_arn" {
  description = "IAM role ARN used by EKS worker nodes"
  value       = module.iam.eks_node_role_arn
}

output "eks_cluster_role_arn" {
  description = "IAM role ARN used by EKS cluster"
  value       = module.iam.eks_cluster_role_arn
}

output "eks_cluster_name" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_version" {
  value = module.eks.cluster_version
}

output "node_group_name" {
  description = "EKS node group name"
  value       = module.eks.node_group_name
}

output "node_group_arn" {
  description = "EKS node group ARN"
  value       = module.eks.node_group_arn
}
output "node_group_status" {
  description = "EKS node group status"
  value       = module.eks.node_group_status
}