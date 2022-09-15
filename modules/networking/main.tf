
 resource "aws_vpc" "LL-TEST-vpc" {                # Creating VPC here
   cidr_block       = "10.0.0.0/16"    
   instance_tenancy = "default"
 }

 resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.LL-TEST-vpc.id            # vpc_id will be generated after we create VPC
 }
 
 resource "aws_subnet" "publicsubnet1" {    # Creating Public Subnets
   vpc_id =  aws_vpc.LL-TEST-vpc.id 
   cidr_block = "10.0.101.0/24"        # CIDR block of public subnets
 }
 resource "aws_subnet" "publicsubnet2" {    # Creating Public Subnets
   vpc_id =  aws_vpc.LL-TEST-vpc.id 
   cidr_block = "10.0.102.0/24"        # CIDR block of public subnets
 }
                                               # Creating Private Subnets
 resource "aws_subnet" "privatesubnet1" {
   vpc_id =  aws_vpc.LL-TEST-vpc.id 
   cidr_block = "10.0.1.0/24"          # CIDR block of private subnets
 }
 resource "aws_subnet" "privatesubnet2" {
   vpc_id =  aws_vpc.LL-TEST-vpc.id 
   cidr_block = "10.0.2.0/24"          # CIDR block of private subnets
 }
 
 resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.LL-TEST-vpc.id 
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
     }
 }
 
 resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.LL-TEST-vpc.id 
   route {
   cidr_block = "0.0.0.0/0"                 # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.NATgw.id
   }
 }
                                            # Route table Association with Public Subnet's
 resource "aws_route_table_association" "PublicRTassociation" {
    subnet_id = aws_subnet.publicsubnet1.id
    route_table_id = aws_route_table.PublicRT.id
 }
                                            #Route table Association with Private Subnet's
 resource "aws_route_table_association" "PrivateRTassociation" {
    subnet_id = aws_subnet.privatesubnet1.id
    route_table_id = aws_route_table.PrivateRT.id
 }
 resource "aws_eip" "nateIP" {
   vpc   = true
 }
 #                                          Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.publicsubnet1.id
 }

 // SG to allow SSH connections from anywhere
resource "aws_security_group" "allow_ssh_pub" {
  name        = "${var.namespace}-allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.LL-TEST-vpc.id

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
}

