output "vpc_id" {
  value = aws_vpc.LL-TEST-vpc.id
}

output "sg_pub_id" {
  value = aws_security_group.allow_ssh_pub.id
}

output "private_subnet" {
  value = aws_subnet.privatesubnet1.id
}

output "public_subnet" {
  value = aws_subnet.publicsubnet1.id
}