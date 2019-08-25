# File:
#  - modules/vpc/private_subnets.tf

#
# VPC2 Default Route Table
data "aws_route_table" "rt_vpc2" {
  vpc_id = "${aws_vpc.vpc2.id}"
  route_table_id = "${aws_vpc.vpc2.main_route_table_id}"
}
#
# Configure Private Subnets for VPC2
resource "aws_subnet" "private_subnets_vpc2" {
  count = "${length(var.availability_zones)}"

  vpc_id = "${aws_vpc.vpc2.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc2.cidr_block, 4, count.index)}"
  availability_zone = "${var.availability_zones[count.index]}"

  tags = {
    Name = "Subnet${count.index+1}-VPC2-Private"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
    Tier = "Private"
  }
}
#
# Configure Route Tables for Private Subnets
resource "aws_route_table" "rt_private_vpc2" {
  count = "${length(var.availability_zones)}"

  vpc_id = "${aws_vpc.vpc2.id}"

  route {
    cidr_block = "${aws_vpc.vpc1.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.pcx_vpc1_vpc2.id}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_vpc2[count.index].id}"
  }

  tags = {
    Name = "RouteTable${count.index+1}-VPC2-Private"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
    Tier = "Private"
  }
}

resource "aws_route_table_association" "rta_private_vpc2" {
  count = "${length(aws_subnet.private_subnets_vpc2)}"

  subnet_id = "${element(aws_subnet.private_subnets_vpc2[*].id, count.index)}"
  route_table_id = "${element(aws_route_table.rt_private_vpc2[*].id, count.index)}"
}
