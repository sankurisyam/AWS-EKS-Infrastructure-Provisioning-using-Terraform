resource "aws_eks_cluster" "this" {
  name     = var.name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  access_config {
    authentication_mode = "API"
  }

  vpc_config {
    subnet_ids = var.private_subnets

    endpoint_private_access = true
    endpoint_public_access  = true

    public_access_cidrs = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = var.name
  }
}
resource "aws_eks_node_group" "this"{
  cluster_name = aws_eks_cluster.this.name
  node_group_name = "${var.name}-node-group"
  node_role_arn = var.node_role_arn

  subnet_ids = var.private_subnets
  instance_types = [ "t3.micro" ]
  capacity_type = "ON_DEMAND"
  scaling_config {
    min_size = 1
    desired_size = 2
    max_size = 3
  }
  update_config {
    max_unavailable = 1
  }

  labels = {
    workload   = "general"
    managed_by = "terraform"
  }

  tags = {
    Name        = var.name
    Environment = "dev"
  }
}

resource "aws_eks_addon" "vpc_cni"{
  cluster_name = aws_eks_cluster.this.name
  addon_name = "vpc-cni"
  addon_version = var.vpc_cni_addon

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [ aws_eks_node_group.this ]
}


resource "aws_eks_addon" "dnscore" {
  cluster_name = aws_eks_cluster.this.name
  addon_name = "coredns"
  addon_version = var.core_dns_addon
resolve_conflicts_on_create = "OVERWRITE"
resolve_conflicts_on_update = "PRESERVE"
depends_on = [ aws_eks_node_group.this ]

}