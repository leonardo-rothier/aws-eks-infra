locals {
    # Environment config
    env = "develop"
    aws_region = "us-east-1"
    vpc_cidr = "10.0.0.0/16"
    azs = ["us-east-1a", "us-east-1b"]

    # Resource naming
    resource_prefix = local.env
    eks_name = "test"

    private_subnets = {
        for idx, az in local.azs : 
        "private_${idx + 1}" => {
            cidr = cidrsubnet(local.vpc_cidr, 6, idx * 4)
            az   = az
            name = "${local.env}-private-${az}"
        }
    }
  
    public_subnets = {
        for idx, az in local.azs : 
        "public_${idx + 1}" => {
            cidr = cidrsubnet(local.vpc_cidr, 6, (idx * 4) + 4*length(local.private_subnets))
            az   = az
            name = "${local.env}-public-${az}"
        }
    }

    # EKS configs
    eks_version = "1.32"

}