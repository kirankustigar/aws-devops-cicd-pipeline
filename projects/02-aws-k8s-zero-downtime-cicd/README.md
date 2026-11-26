# Project 02: Zero-Downtime Kubernetes CI/CD Pipeline on AWS

Automated cloud provisioning, server configuration, container packaging, and zero-downtime Kubernetes rolling deployments using **Terraform, Ansible, Jenkins, Docker, and Kubernetes (k3s)**.

## Architecture Flow
1. **Terraform (`terraform/`):** Provisions a `t3.small` Ubuntu node in `ap-south-1`, SSH key pair, and Security Group (ports `22`, `8080`, `30080`).
2. **Ansible (`ansible/setup.yml`):** Configures 2GB Linux swap space, Docker Engine, `k3s` Kubernetes cluster, and a host-networked Jenkins controller container.
3. **Kubernetes (`k8s/deployment.yaml`):** Runs 2 Nginx application Pods (`replicas: 2`) with `maxUnavailable: 0` rolling update strategy behind NodePort `30080`.
4. **Jenkins (`jenkins/Jenkinsfile`):** Pulls GitHub updates, builds versioned Docker images (`v2.${BUILD_NUMBER}`), and triggers zero-downtime `kubectl set image` + `kubectl rollout status` updates.
