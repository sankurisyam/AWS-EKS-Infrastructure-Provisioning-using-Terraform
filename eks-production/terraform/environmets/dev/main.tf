module "vpc" {
  source = "../../modules/vpc"

  name        = "eks-${var.environment}"
  environment = var.environment
}

module "iam" {
  source = "../../modules/iam"
  name   = "eks-${var.environment}"

}
module "eks" {
  source             = "../../modules/eks"
  name               = "eks-${var.environment}"
  kubernetes_version = var.kubernetes_version
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  private_subnets    = module.vpc.private_subnet_ids

  node_role_arn = module.iam.eks_node_role_arn
  depends_on    = [module.iam]

} 