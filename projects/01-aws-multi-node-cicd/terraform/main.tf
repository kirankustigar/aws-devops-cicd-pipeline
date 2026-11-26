provider "aws" {
  region = "ap-south-1"
}

# Fetch latest Ubuntu 22.04 LTS AMI in Mumbai
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Upload local SSH public key to AWS
resource "aws_key_pair" "devops_key" {
  key_name   = "devops-lab-key"
  public_key = file("~/.ssh/devops-key.pub")
}

# Security Group allowing SSH, Jenkins (8080), SonarQube (9000), JFrog (8081/8082)
resource "aws_security_group" "devops_sg" {
  name        = "devops-cicd-sg"
  description = "Allow SSH and CI/CD tool ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 1. Jenkins Master Server
resource "aws_instance" "jenkins_master" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "Jenkins-Master"
  }
}

# 2. Jenkins Slave (Maven + Docker)
resource "aws_instance" "jenkins_slave" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "Jenkins-Slave"
  }
}

# 3. SonarQube & JFrog Server (30GB Disk for Docker Images)
resource "aws_instance" "sonar_jfrog" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.large"
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "SonarQube-JFrog"
  }
}

output "jenkins_master_ip" {
  value = aws_instance.jenkins_master.public_ip
}

output "jenkins_slave_ip" {
  value = aws_instance.jenkins_slave.public_ip
}

output "sonar_jfrog_ip" {
  value = aws_instance.sonar_jfrog.public_ip
}
