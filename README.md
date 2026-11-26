# AWS DevOps & Cloud Automation Portfolio

Production-style Infrastructure as Code (IaC), Configuration Management, and Containerized CI/CD architectures implemented on **AWS (`ap-south-1`)**.

## Projects Included

### [01. Multi-Node Enterprise CI/CD Pipeline](./projects/01-aws-multi-node-cicd)
* **Stack:** AWS EC2, Terraform, Ansible, Jenkins (Master-Slave SSH Agents), Maven, Docker, SonarQube, Sonatype Nexus
* **Highlights:** Automated 3-server provisioning, distributed build isolation across SSH agents, static code quality gates (`0 Bugs, 0 Vulnerabilities`), and versioned `.jar` artifact publishing.

### [02. Zero-Downtime Kubernetes Rolling-Update Pipeline](./projects/02-aws-k8s-zero-downtime-cicd)
* **Stack:** AWS EC2, Modular Terraform (`variables.tf`, `main.tf`, `outputs.tf`), Ansible, Docker, Jenkins, Kubernetes (`k3s`)
* **Highlights:** Automated `v1.0` -> `v2.0` live web release across 2 load-balanced Kubernetes Pods (`NodePort 30080`) with `maxUnavailable: 0` zero-downtime rolling updates.
