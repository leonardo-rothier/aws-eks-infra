module "eks_network" {
    source = "./modules/eks-network"

    vpc_name = "${local.resource_prefix}-main"
    vpc_cidr = local.vpc_cidr

    igw_name = "${local.resource_prefix}-igw"

    private_subnets = local.private_subnets
    public_subnets = local.public_subnets
    azs = local.azs

    cluster_name = "${local.resource_prefix}-${local.eks_name}"

    nat_eip_name = "${local.resource_prefix}-nat"
    private_table = "${local.resource_prefix}-private"
    public_table = "${local.resource_prefix}-public"
}

module "eks_cluster" {
    source = "./modules/eks"

    eks_name = "${local.resource_prefix}-${local.eks_name}"
    eks_version = local.eks_version

    private_subnet_ids = module.eks_network.private_subnet_ids
    public_subnet_ids = module.eks_network.public_subnet_ids

    vpc_id = module.eks_network.vpc_id
}