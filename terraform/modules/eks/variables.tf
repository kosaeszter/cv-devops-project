variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  default = "kosaeszter-eks-cluster"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for EKS worker nodes"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the EKS cluster"
  default     = {
    Name = "kosaeszter-eks-cluster"
  }
}