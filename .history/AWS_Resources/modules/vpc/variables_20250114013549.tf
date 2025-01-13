variable "vpc_cidr"{
    description ="cidr block for the vpc"
    default     ="10.0.0.0/16"
}

variable "availability_zone" {
    description = "AZ for subnet-1"
    default = "us-east-1a" 
}

variable "aws_subnet_1" {
    description ="CIDR block for CIDR-1"
    default = "10.0.0.0/24"     
}

variable "availability_zone_s1" {
  description = "Availability Zone for Subnet 1"
  default     = "us-east-1a"
}

variable "aws_subnet_2" {
    description ="CIDR block for CIDR-2"
    default = "10.0.1.0/24" 
}

variable "availability_zone_s2" {
  description = "Availability Zone for Subnet 2"
  default     = "us-east-1b"
}

variable "aws_subnet_rt_1"{
    description = "CIDR value for rt-1"
    default = "0.0.0.0/0"
}

variable "aws_subnet_rt_2"{
    description = "CIDR value for rt-2"
    default = "0.0.0.0/0"
}

variable "ingress_sg" {
    description ="inbound security values for TCP,HTTP,HTTPS"
    default = ["0.0.0.0/0"]
}

variable "egress_sg" {
    description ="outbound security value"
    default = ["0.0.0.0/0"]
}