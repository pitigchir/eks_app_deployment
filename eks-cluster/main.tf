# Contains the eks cluster definition created using the terraform-aws-modules/eks/aws module. Module version and cluster version can be updated
# with the latest available versions. Attributes may change according to the versions. Details can be found under https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.5.1"
  cluster_name    = local.cluster_name
  cluster_version = "1.24"
  cluster_endpoint_public_access = true
  subnet_ids      = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"
      instance_types = ["t3.small"]
      capacity_type  = "SPOT"  # Spot instances used to reduce the cost
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
    two = {
      name = "node-group-2"

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}
