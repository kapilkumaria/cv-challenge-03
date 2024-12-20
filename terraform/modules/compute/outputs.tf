output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.ec2_sg.id
}

output "instance_ids" {
  description = "List of IDs of the EC2 instances"
  value       = aws_instance.compute[*].id
}

output "public_ips_old" {
  description = "List of public IPs of the EC2 instances"
  value       = aws_instance.compute[*].public_ip
}

output "private_ips" {
  description = "List of private IPs of the EC2 instances"
  value       = aws_instance.compute[*].private_ip
}

output "public_ips" {
  value = aws_instance.compute.*.public_ip
}
