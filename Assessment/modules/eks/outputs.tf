output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = aws_eks_cluster.this.id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "eks_cluster_arn" {
  description = "EKS Cluster ARN"
  value       = aws_eks_cluster.this.arn
}

output "eks_cluster_security_group" {
  description = "EKS Cluster Security Group ID"
  value       = aws_security_group.control_plane_sg.id
}
