module "eks_network" {
    source = "./modules/eks-network"

    vpc_name = "${local.resource_prefix}-main"
    igw_name = "${local.resource_prefix}-igw"

    vpc_cidr = local.vpc_cidr

    private_subnets = local.private_subnets
    public_subnets = local.public_subnets
    azs = local.azs

    cluster_name = "${local.resource_prefix}-${local.eks_name}"

    nat_eip_name = "${local.resource_prefix}-nat"
    private_table = "${local.resource_prefix}-private"
    public_table = "${local.resource_prefix}-public"
}

