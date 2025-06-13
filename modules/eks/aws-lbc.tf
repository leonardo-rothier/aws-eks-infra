# Who can assume this role:
data "aws_iam_policy_document" "aws_lbc" {
    statement {
      effect = "Allow"

      principals {
        type = "Service"
        identifiers = ["pods.eks.amazonaws.com"]
      }

      actions = [
        "sts:AssumeRole",
        "sts:TagSession"
      ]
    }
}

# role:
resource "aws_iam_role" "aws_lbc" {
    name = "${aws_eks_cluster.eks.name}-aws-lbc"
    assume_role_policy = data.aws_iam_policy_document.aws_lbc.json
}

# The actual permissions of the new role:
resource "aws_iam_policy" "aws_lbc" {
    policy = file("${path.module}/iam/AWSLoadBalancerController.json")
    name = "AWSLoadBalancerController"
}

resource "aws_iam_role_policy_attachment" "aws_lbc" {
    role = aws_iam_role.aws_lbc.name
    policy_arn = aws_iam_policy.aws_lbc.arn
}

# Binds the role to Kubernetes service account:
resource "aws_eks_pod_identity_association" "aws_lbc" {
    cluster_name = aws_eks_cluster.eks.name
    namespace = "kube-system"
    service_account = "aws-load-balancer-controller"
    role_arn = aws_iam_role.aws_lbc.arn
}

resource "helm_release" "aws_lbc" {
    name = "aws-load-balancer-controller"

    # https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller/1.13.2
    repository = "https://aws.github.io/eks-charts"
    chart = "aws-load-balancer-controller"
    namespace = "kube-system"
    version = "1.13.2"

    set {
        name = "clusterName"
        value = aws_eks_cluster.eks.name
    }

    set {
        name = "vpcId"
        value = var.vpc_id
    }

    depends_on = [ 
        aws_eks_node_group.general,
        aws_eks_pod_identity_association.aws_lbc,
        aws_iam_role_policy_attachment.aws_lbc
    ]

}