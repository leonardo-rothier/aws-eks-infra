provider "aws" {
    region = local.aws_region
}

provider "helm" {
    kubernetes {
        host = module.eks_cluster.cluster_endpoint
        cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)
        token = module.eks_cluster.cluster_auth_token
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