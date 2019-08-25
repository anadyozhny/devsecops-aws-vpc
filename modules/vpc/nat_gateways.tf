# File:
#  - modules/vpc/nat_gateways.tf


#
# Allocate ElasticIP for NAT Gateways
resource "aws_eip" "nat_eip" {
  count = "${length(var.availability_zones)}"

  tags = {
    Name = "EIP-NAT-Subnet${count.index+1}-VPC2"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }

  depends_on = [ "aws_internet_gateway.igw_vpc2" ]
}

#
# NAT Gateways for VPC2
resource "aws_nat_gateway" "nat_vpc2" {
  count = "${length(var.availability_zones)}"

  subnet_id = "${aws_subnet.public_subnets_vpc2[count.index].id}"
  allocation_id = "${aws_eip.nat_eip[count.index].id}"

  tags = {
    Name = "NAT-Subnet${count.index+1}-VPC2"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }

  depends_on = [ "aws_internet_gateway.igw_vpc2" ]
}

#
# Deafult route for VPC2 private route Table
#resource "aws_route" "default_private_vpc2" {
#  route_table_id = "${data.aws_route_table.rt_vpc2.id}"
#  destination_cidr_block = "0.0.0.0/0"
#  nat_gateway_id = "${aws_nat_gateway.nat_vpc2[1].id}"
#
#  depends_on = [ "aws_nat_gateway.nat_vpc2[1]" ]
#}
