output "vpc1_id" {
  value = "${aws_vpc.vpc1.id}"
}

output "vpc2_id" {
  value = "${aws_vpc.vpc2.id}"
}

output "subnets_vpc1" {
  value = "${aws_subnet.public_subnets_vpc1}"
}

output "subnets_vpc2" {
  value = "${aws_subnet.private_subnets_vpc2}"
}

output "bastion_sg_id" {
  value = "${aws_security_group.bastion_sg_vpc1.id}"
}

output "internal_sg_id" {
  value = "${aws_security_group.internal_sg_vpc2.id}"
}
