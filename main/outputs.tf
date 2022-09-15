output "public_connection_string" {
  description = "Copy/Paste/Enter - You are in the matrix"
  value       = "Public_IP${module.ec2.public_ip}"
}

output "private_connection_string" {
  description = "Copy/Paste/Enter - You are in the private ec2 instance"
  value       = "Private_IP${module.ec2.private_ip}"
}