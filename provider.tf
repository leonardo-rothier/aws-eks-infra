provider "aws" {
    region = local.aws_region
}

data "aws_eks_cluster" "eks" {
    name = module.eks_cluster.eks_name
}

data "aws_eks_cluster_auth" "eks" {
    name = module.eks_cluster.eks_name
}

provider "helm" {
    kubernetes {
        host = data.aws_eks_cluster.eks.endpoint
        cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
        token = data.aws_eks_cluster_auth.eks.token
    }
}

terraform {
    required_version = ">= 1.11"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.99.1"
        }
        helm = {
            source = "hashicorp/helm"
            version = "~> 2.17.0"
        }
    }
}