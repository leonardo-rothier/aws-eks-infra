# AWS EKS Infrastructure with Terraform

This project provisions a production-ready Amazon EKS (Elastic Kubernetes Service) cluster along with its supporting network infrastructure using Terraform.

## Overview
This Terraform project automates the deployment of:
- AWS VPC with public and private subnets
- EKS cluster with managed node groups
- IAM roles and policies for EKS
- Network components (IGW, NAT Gateway, Route Tables)
- Setup NLB(Network Load Balancer) in AWS to routes traffic with k8s Ingress controller

## Prerequisites
- Terraform >= 1.11
- AWS CLI configured with appropriate credentials
- kubectl (for interacting with the cluster post-deployment)
- AWS IAM permissions to create:
  - VPC and networking resources
  - EKS clusters
  - IAM roles and policies

## Getting Started

1. **Clone the repository**
```bash
    git clone https://github.com/leonardo-rothier/aws-eks-infra.git
    cd aws-eks-infra  
```
2. **Clone the repository**
```bash
    terraform init
```  

3. **Configure variables**
On locals you can set your configurations, to modify the values that are passed to the modules variables and adapt to your needs  

4. **Apply terraform**
```bash
    terraform apply
```  

5. **Connect to the EKS**  
We need to update the local kubeconfig with the following command:  
```bash
    aws eks update-kubeconfig \
    --region us-east-1
    --name develop-test
```  

6. **Deploy some testing applications**
I've created 3 options to deploy:
0 - Testing horizontal pod autoscaling with metric server
1 - Testing Load Balancer Controller, using NLB(Network Load Balancer) 
2 - Testing LBC, with ALB(Application Load Balancer) and ingress.  

For just one exposed service is preferable the NLB because it works on layer 4 so it's simpler and will cost less.  
ALB despite that works on layer 7 (so is more expensive), it can be way more cost effective than NLB if is needed to expose multiple services. The ALB can be used with ingress and instead of provision multiples load balancer, we can use just one for several services.

To test:

```bash
kubectl apply -f 0-test-hpa-with-metrics/
kubectl apply -f 1-test-lbc-with-nlb/
kubectl apply -f 2-test-lbc-with-alb-ingress/
```