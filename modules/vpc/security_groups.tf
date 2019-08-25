# File:
#  - modules/vpc/security_groups.tf


resource "aws_security_group" "bastion_sg_vpc1" {
  name = "Bastion-SG-VPC1"
  description = "Bastion Host Secutity Group"
  vpc_id = "${aws_vpc.vpc1.id}"

  tags = {
    Name = "Bastion-SG-VPC1"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal_sg_vpc2" {
  name = "Inaternal-SG-VPC2"
  description = "Internal Host Secutity Group"
  vpc_id = "${aws_vpc.vpc2.id}"

  tags = {
    Name = "Internal-SG-VPC2"
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${aws_vpc.vpc1.cidr_block}"]
  }

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["${aws_vpc.vpc1.cidr_block}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
