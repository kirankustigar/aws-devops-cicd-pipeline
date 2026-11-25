# End-to-End AWS DevOps CI/CD Pipeline

Automated cloud infrastructure provisioning, configuration management, static code analysis, and containerized CI/CD pipeline built on AWS (`ap-south-1`).

## Architecture & Tech Stack
* **Cloud Provider:** AWS (EC2 `t3.medium` / `t3.large`, Security Groups, EBS Storage, Key Pairs in Mumbai `ap-south-1`)
* **Infrastructure as Code (IaC):** Terraform (`terraform/main.tf`)
* **Configuration Management:** Ansible (`ansible/setup-tools.yml`, `ansible/inventory.ini`)
* **CI/CD Orchestration:** Distributed Jenkins Master-Slave architecture (`jenkins/Jenkinsfile`)
* **Build & Containerization:** Apache Maven (Java 17) & Docker (`Dockerfile`, `app/`)
* **Code Quality & Artifact Storage:** SonarQube (Quality Gate & Static Analysis) + Sonatype Nexus Repository

## Key DevOps Workflows Implemented
1. **Infrastructure Provisioning:** Provisioned 3 Ubuntu EC2 instances and least-privilege security rules via Terraform.
2. **Automated Tooling Setup:** Configured Jenkins Master, dedicated Maven/Docker Build Slave, SonarQube, and Nexus via Ansible.
3. **Distributed CI/CD Pipeline:** Offloaded Maven builds and Docker image creation from Jenkins Master to an SSH-connected Linux build agent (`build-slave-1`).
4. **Code Quality & Artifact Management:** Analyzed source code via SonarQube Quality Gates (`0 Bugs, 0 Vulnerabilities`) and published release `.jar` artifacts to Sonatype Nexus.
