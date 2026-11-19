output "cluster_id" {
  value = aws_eks_cluster.this.id
}

output "cluster_arn"{
    value = aws_eks_cluster.this.arn
}

output "cluster_endpoint"{
    value = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "Kubernetes version"
  value       = aws_eks_cluster.this.version
}

output "cluster_security_group_id" {
  description = "EKS cluster security group"
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "node_group_name"{
  description = "EKS node group name"
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_arn"{
  description = "EKS node group ARN"
  value       = aws_eks_node_group.this.arn
}
output "node_group_status"{
  description = "EKS node group status"
  value       = aws_eks_node_group.this.status
}