variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_subnet_1" {
  description = "CIDR block for subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "aws_subnet_2" {
  description = "CIDR block for subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone_s1" {
  description = "Availability Zone for subnet 1"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_s2" {
  description = "Availability Zone for subnet 2"
  type        = string
  default     = "us-east-1b"
}

variable "ingress_sg" {
  description = "CIDR blocks for inbound traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_sg" {
  description = "CIDR blocks for outbound traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
