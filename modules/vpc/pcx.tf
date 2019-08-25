# File:
#  - modules/vpc/pcf.tf

#
# Establish Peering between configured VPCs
resource "aws_vpc_peering_connection" "pcx_vpc1_vpc2" {
  vpc_id = "${aws_vpc.vpc1.id}"
  peer_vpc_id = "${aws_vpc.vpc2.id}"
  auto_accept = true

  tags = {
    Name = "PCX-VPC1-VPC2"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }
}
#
# Confirure Peering Routes
resource "aws_route" "peering_vpc1" {
  route_table_id = "${data.aws_route_table.rt_vpc1.id}"
  destination_cidr_block = "${aws_vpc.vpc2.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.pcx_vpc1_vpc2.id}"
}
#
resource "aws_route" "peering_vpc2" {
  route_table_id = "${data.aws_route_table.rt_vpc2.id}"
  destination_cidr_block = "${aws_vpc.vpc1.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.pcx_vpc1_vpc2.id}"
}
