output "elb_dns_name" {
  description = "The DNS name of the Load Balancer"
  value       = aws_lb.this.dns_name
}

output "instance_1_public_ip" {
  description = "The public IP of the first EC2 instance"
  value       = aws_instance.web1.public_ip
}

output "instance_2_public_ip" {
  description = "The public IP of the second EC2 instance"
  value       = aws_instance.web2.public_ip
}
