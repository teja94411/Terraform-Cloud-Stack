variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the instances and load balancer"
  type        = list(string)
}

variable "elb_name" {
  description = "The name of the Elastic Load Balancer"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs for the load balancer and instances"
  type        = list(string)
}
