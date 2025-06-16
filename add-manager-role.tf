data "aws_caller_identity" "current" { }

resource "aws_iam_role" "eks_admin" {
    name = "${local.env}-${local.eks_name}-eks-admin"

    assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "sts:AssumeRole",
                "Principal": {
                    "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
                }
            }
        ]
    }
    POLICY

}

resource "aws_iam_policy" "eks_admin" {
  name = "AmazonEKSAdminPolicy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "eks.amazonaws.com"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_admin" {
    role = aws_iam_role.eks_admin.name
    policy_arn = aws_iam_policy.eks_admin.arn
}

resource "aws_iam_user" "manager" {
    name = "manager"
    
    lifecycle {
      prevent_destroy = true
    }
}

resource "aws_iam_policy" "eks_assume_admin" {
  name = "AmazonEKSAssumeAdminPolicy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "${aws_iam_role.eks_admin.arn}"
        }
    ]
}
POLICY
}

resource "aws_iam_user_policy_attachment" "manager" {
    user = aws_iam_user.manager.name
    policy_arn = aws_iam_policy.eks_assume_admin.arn
}

resource "aws_eks_access_entry" "manager" {
  cluster_name      = module.eks_cluster.eks_name
  principal_arn     = aws_iam_role.eks_admin.arn
  kubernetes_groups = ["my-admin"]
}

/*
To assume role:
aws sts assume-role \
--role-arn <role-arn> \
--role-session-name manager-session \
--profile manager

create new profile on ~/.aws/config
and update kubeconfig to use a role based credential (eks-admin):
aws eks update-kubeconfig \
> --region us-east-1 \
> --name develop-test \
> --profile eks-admin
*/