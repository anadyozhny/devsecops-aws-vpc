# File:
#  - modules/vpc/internet_gateways.tf

#
# Internet Gateway for VPC1
resource "aws_internet_gateway" "igw_vpc1" {
  vpc_id = "${aws_vpc.vpc1.id}"

  tags = {
    Name = "IGW-VPC1"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }
}


#
# Internet Gateway for VPC2
resource "aws_internet_gateway" "igw_vpc2" {
  vpc_id = "${aws_vpc.vpc2.id}"

  tags = {
    Name = "IGW-VPC2"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }
}
