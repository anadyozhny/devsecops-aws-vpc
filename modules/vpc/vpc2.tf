# File:
#  - modules/vpc/vpc2.tf

#
# Configure VPC2
resource "aws_vpc" "vpc2" {
  cidr_block = "${var.cidr_vpc2}"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC2"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }
}

#
# Configure Secondary CIDR for VPC2
resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr_vpc2" {
  vpc_id     = "${aws_vpc.vpc2.id}"
  cidr_block = "${var.cidr_vpc2_secondary}"
}

#
# Configure Route Table for VPC2 Public Subnets
resource "aws_route_table" "rt_public_vpc2" {
  vpc_id = "${aws_vpc.vpc2.id}"

  tags = {
    Name = "RT-VPC2-Public"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }
}
#
resource "aws_route" "default_vpc2" {
  route_table_id = "${aws_route_table.rt_public_vpc2.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw_vpc2.id}"
}
