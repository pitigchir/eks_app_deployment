# Outputs of application deployment

output "load_balancer_hostname" {
  description = "Hostname of the load balancer"
  value       = kubernetes_service.app_service.status.0.load_balancer.0.ingress.0.hostname
}