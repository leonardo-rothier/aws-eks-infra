variable "eks_name" {
    type = string
    description = "EKS cluster name"
}

variable "eks_version" {
    type = string
    default = "1.32"
    description = "Latest supported Kubernetes version in AWS"
}

variable "private_subnet_ids" {
    type = list(string)
    description = "List of private subnet IDs"
}

variable "public_subnet_ids" {
    type = list(string)
    description = "List of public subnet IDs"
}

variable "node_group_instance_types" {
    type = list(string)
    description = "The instance types used for the EKS nodes"
    default = [ "t3.small" ]
}