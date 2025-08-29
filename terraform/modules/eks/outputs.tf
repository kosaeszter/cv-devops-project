output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  value       = aws_eks_cluster.cluster.endpoint
}

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.cluster.name
}