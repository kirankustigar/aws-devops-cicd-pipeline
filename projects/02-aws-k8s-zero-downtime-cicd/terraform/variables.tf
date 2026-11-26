variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance size for single-node Jenkins + Docker + k3s cluster"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI in ap-south-1"
  type        = string
  default     = "ami-0f5ee92e2d63afc18"
}
