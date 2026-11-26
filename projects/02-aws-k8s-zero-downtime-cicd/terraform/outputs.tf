output "server_public_ip" {
  description = "Public IPv4 address of the AWS DevOps K8s node"
  value       = aws_instance.devops_server.public_ip
}

output "jenkins_url" {
  description = "Jenkins CI/CD web interface"
  value       = "http://${aws_instance.devops_server.public_ip}:8080"
}

output "kubernetes_app_url" {
  description = "Live Kubernetes NodePort application URL"
  value       = "http://${aws_instance.devops_server.public_ip}:30080"
}
