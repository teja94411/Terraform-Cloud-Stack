output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.webserver.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.webserver.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.webserver.private_ip
}

output "security_group_id" {
  description = "The ID of the created security group"
  value       = aws_security_group.allow_ssh.id
}

output "key_pair_name" {
  description = "The name of the created key pair"
  value       = aws_key_pair.this.key_name
}

output "pem_file_path" {
  description = "The local path where the PEM file was saved"
  value       = local_file.private_key_pem.filename
}
