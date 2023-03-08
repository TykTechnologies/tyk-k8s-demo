provider "aws" {
	region = var.cluster_location
}

data "aws_availability_zones" "this" {}
data "aws_caller_identity" "this" {}


module "vpc" {
	source = "terraform-aws-modules/vpc/aws"

	name                 = "pt-${var.cluster_location}-vpc"
	cidr                 = "10.0.0.0/16"
	azs                  = data.aws_availability_zones.this.names
	private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
	public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
	enable_nat_gateway   = true
	single_nat_gateway   = true
	enable_dns_hostnames = true
}

module "ebs_csi_controller_role" {
	source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
	create_role                   = true
	role_name                     = "${module.eks.cluster_name}-ebs-csi-controller"
	provider_url                  = module.eks.cluster_oidc_issuer_url
	role_policy_arns              = ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]
	oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

module "eks" {
	source = "terraform-aws-modules/eks/aws"

	cluster_name    = "tyk-demo-${var.cluster_location}"
	cluster_version = "1.24"

	vpc_id     = module.vpc.vpc_id
	subnet_ids = module.vpc.private_subnets

	cluster_endpoint_public_access = true
}

module "eks_node_groups" {
	source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"

	name            = "${module.eks.cluster_name}-np"
	cluster_name    = module.eks.cluster_name
	cluster_version = module.eks.cluster_version
	subnet_ids      = module.vpc.private_subnets
	desired_size    = var.cluster_node_count
	instance_types  = [var.cluster_machine_type]
}

resource "aws_eks_addon" "this" {
	cluster_name             = module.eks.cluster_name
	addon_name               = "aws-ebs-csi-driver"
	resolve_conflicts   		 = "OVERWRITE"
	service_account_role_arn = module.ebs_csi_controller_role.iam_role_arn
	depends_on               = [module.eks, module.eks_node_groups]
}

data "aws_eks_cluster_auth" "this" {
	name = module.eks.cluster_name

	depends_on = [module.eks, module.eks_node_groups]
}
