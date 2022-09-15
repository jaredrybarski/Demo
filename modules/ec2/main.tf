// Configure the EC2 instance in a public subnet
resource "aws_instance" "ec2_public" {
  ami                         = "ami-018d291ca9ffc002f"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "mainc"
  subnet_id                   = var.public_subnets
  vpc_security_group_ids      = [var.sg_pub_id]

  tags = {
    "Name" = "${var.namespace}-EC2-PUBLIC"
  }
}
// Configure the EC2 instance in a private subnet
resource "aws_instance" "ec2_private" {
  ami                         = "ami-018d291ca9ffc002f"
  associate_public_ip_address = false
  instance_type               = "t2.micro"
  key_name                    = "mainc"
  subnet_id                   = var.private_subnets
  vpc_security_group_ids      = [var.sg_priv_id]

  tags = {
    "Name" = "${var.namespace}-EC2-PRIVATE"
  }

}