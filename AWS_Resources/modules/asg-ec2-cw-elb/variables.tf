# VPC Configuration Variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "aws_subnet_1" {
  description = "CIDR block for subnet 1"
  type        = string
}

variable "aws_subnet_2" {
  description = "CIDR block for subnet 2"
  type        = string
}

variable "availability_zone_s1" {
  description = "Availability zone for subnet 1"
  type        = string
}

variable "availability_zone_s2" {
  description = "Availability zone for subnet 2"
  type        = string
}

# EC2 Configuration
variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

# Security Group Configuration
variable "ingress_sg" {
  description = "CIDR block for inbound rules"
  type        = list(string)
}

variable "egress_sg" {
  description = "CIDR block for outbound rules"
  type        = list(string)
}

# Load Balancer Configuration
variable "elb_name" {
  description = "The name of the ELB"
  type        = string
}
