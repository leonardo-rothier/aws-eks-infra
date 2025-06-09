variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "AWS vpc cidr block"
}

variable "vpc_name" {
  type        = string
  default     = "main"
  description = "VPC name"
}

variable "igw_name" {
  type        = string
  default     = "igw"
  description = "Internet Gateway name"
}

variable "azs" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "AWS availability zones"
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
  description = "VPC private subnets"
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
  description = "VPC public subnets"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "mycluster"
}

variable "nat_eip_name" {
  description = "NAT Elastic IP name"
  type        = string
  default     = "nat-eip"
}

variable "private_table" {
  description = "Private route table name"
  type        = string
  default     = "private"
}

variable "public_table" {
  description = "Public route table name"
  type        = string
  default     = "public"
}
