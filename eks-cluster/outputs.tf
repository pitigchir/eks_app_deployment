# Outputs genrerated by EKS cluster

output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_token" {
  description = "Endpoint for EKS control plane."
  value       = data.aws_eks_cluster_auth.cluster.token
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Endpoint for EKS control plane."
  value       = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  sensitive   = true
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}
