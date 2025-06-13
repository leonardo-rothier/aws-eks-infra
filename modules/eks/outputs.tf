output "eks_name" {
    value = aws_eks_cluster.eks.name
}

output "cluster_endpoint" {
    description = "Endpoint for EKS control plane"
    value = aws_eks_cluster.eks.endpoint
}

output "cluster_certificate_authority_data" {
    description = "Base64 enconded certificate data required to communicate with the cluster"
    value = aws_eks_cluster.eks.certificate_authority[0].data
}

output "cluster_auth_token" {
  description = "Token to authenticate with the EKS cluster"
  value       = data.aws_eks_cluster_auth.eks.token
}


