# File:
#  - modules/vpc/public_subnets.tf

#
# Configure Public Subnets for VPC1
resource "aws_subnet" "public_subnets_vpc1" {
  count = "${length(var.availability_zones)}"

  vpc_id = "${aws_vpc.vpc1.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc1.cidr_block, 4, count.index)}"
  availability_zone = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet${count.index+1}-VPC1-Public"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
    Tier = "Public"
  }
}
#
resource "aws_route_table_association" "rta_vpc1" {
  count = "${length(aws_subnet.public_subnets_vpc1)}"

  subnet_id = "${element(aws_subnet.public_subnets_vpc1[*].id, count.index)}"
  route_table_id = "${data.aws_route_table.rt_vpc1.id}"
}

#
# Configure Public Subnets for VPC2
resource "aws_subnet" "public_subnets_vpc2" {
  count = "${length(var.availability_zones)}"

  vpc_id = "${aws_vpc.vpc2.id}"
  cidr_block = "${cidrsubnet(aws_vpc_ipv4_cidr_block_association.secondary_cidr_vpc2.cidr_block, 4, count.index)}"
  availability_zone = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet${count.index+1}-VPC2-Public"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
    Tier = "Public"
  }
}
#
# Associations for Publiuc Subnets
resource "aws_route_table_association" "rta_vpc2" {
  count = "${length(aws_subnet.public_subnets_vpc2)}"

  subnet_id = "${element(aws_subnet.public_subnets_vpc2[*].id, count.index)}"
  route_table_id = "${aws_route_table.rt_public_vpc2.id}"
}
