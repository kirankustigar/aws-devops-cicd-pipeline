provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "k8s_key" {
  key_name   = "k8s-devops-key"
  public_key = file("~/.ssh/devops-key.pub")
}

resource "aws_security_group" "k8s_sg" {
  name        = "k8s-devops-sg"
  description = "Security group for Jenkins controller and Kubernetes NodePort"

  ingress {
    description = "SSH management access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins CI/CD Dashboard"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes Application NodePort"
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic for package and image pulls"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "k8s-devops-sg"
    Project = "aws-k8s-zero-downtime-cicd"
  }
}

resource "aws_instance" "devops_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.k8s_key.key_name
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name    = "AWS-DevOps-K8s-Node"
    Project = "aws-k8s-zero-downtime-cicd"
  }
}
