# File:
#  - modules/vpc/vpc1.tf

#
# Configure VPC1
resource "aws_vpc" "vpc1" {
  cidr_block = "${var.cidr_vpc1}"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC1"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }
}

#
# VPC1 Default Route Table
data "aws_route_table" "rt_vpc1" {
  vpc_id = "${aws_vpc.vpc1.id}"
}
#
resource "aws_route" "default_vpc1" {
  route_table_id = "${data.aws_route_table.rt_vpc1.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw_vpc1.id}"
}
