# AWS EKS Infrastructure with Terraform

This project provisions a production-ready Amazon EKS (Elastic Kubernetes Service) cluster along with its supporting network infrastructure using Terraform.

## Overview
This Terraform project automates the deployment of:
- AWS VPC with public and private subnets
- EKS cluster with managed node groups
- IAM roles and policies for EKS
- Network components (IGW, NAT Gateway, Route Tables)
- Security groups for cluster communication

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