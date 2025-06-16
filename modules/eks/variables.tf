variable "eks_name" {
    type = string
    description = "EKS cluster name"
}

variable "eks_version" {
    type = string
    default = "1.32"
    description = "Latest supported Kubernetes version in AWS"
}

variable "activate_metrics" {
    type = bool
    default = false
    description = "If you wants the metrics server to be installed on your cluster"
}

variable "private_subnet_ids" {
    type = list(string)
    description = "List of private subnet IDs"
}

variable "public_subnet_ids" {
    type = list(string)
    description = "List of public subnet IDs"
}

variable "vpc_id" {
    type = string
    description = "Cluster's VPC id"
} 

variable "node_group_instance_types" {
    type = list(string)
    description = "The instance types used for the EKS nodes"
    default = [ "t3.small" ]
}

variable "node_group_capacity_type" {
    type = string
    description = "The instances capacity type, set SPOT for testing"
    default = "ON_DEMAND"
}