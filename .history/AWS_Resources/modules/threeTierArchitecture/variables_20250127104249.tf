variable "instance_type" {
  description = "instance configuration"
  default = "t2.micro"
}

variable "ami_id" {
  description = "ami value"
  default = "ami-0df8c184d5f6ae949"
}

variable "ec2_server" {
  description = "server name"
  default = "web server"
}

variable "vpc_cidr" {
  description = "cidr block for the vpc"
  default = "10.0.0.0/16"
}

variable "availability_zone_s1" {
  description = "Availability Zone for Subnet 1"
  default = "us-east-1a"
}

variable "aws_subnet_1" {
  description = "CIDR block for CIDR-1"
  default = "10.0.0.0/24"
}

variable "availability_zone_s2" {
  description = "Availability Zone for Subnet 2"
  default = "us-east-1b"
}

variable "aws_subnet_2" {
  description = "CIDR block for CIDR-2"
  default = "10.0.1.0/24"
}

variable "ingress_sg" {
  description = "inbound security values for TCP, HTTP, HTTPS"
  default = ["0.0.0.0/0"]
}

variable "egress_sg" {
  description = "outbound security value"
  default = ["0.0.0.0/0"]
}

variable "public_key_path" {
  description = "Path to the public key file"
  default = "~/.ssh/id_rsa.pub"  # Adjust this path based on your system
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "key_pair_base_download_path" {
  description = "storing ec2 private keys"
  default = "C:/Users/Admin"
}

variable "aws_subnet" {
  description = "CIDR block for CIDR-1"
  default = "10.0.0.0/24"
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances in Auto Scaling Group"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of EC2 instances in Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of EC2 instances in Auto Scaling Group"
  type        = number
  default     = 5
}