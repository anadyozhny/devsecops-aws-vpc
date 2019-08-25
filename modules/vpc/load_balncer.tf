# File:
#  - modules/vpc/load_balancer.tf

resource "aws_lb" "bastion_lb" {
  name = "Bastion-LB"
  internal = false
  load_balancer_type = "network"
  subnets = "${aws_subnet.public_subnets_vpc1.*.id}"

  tags = {
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }
}

resource "aws_lb_target_group" "bastion_ssh_tg" {
  name = "Bastion-SSH-TG"
  port = 22
  protocol = "TCP"
  target_type = "instance"
  vpc_id = "${aws_vpc.vpc1.id}"

  tags = {
    Task = "DevSecOps-AWS"
    Tool = "Terraform"
  }
}

resource "aws_lb_listener" "bastion_ssh" {
  load_balancer_arn = "${aws_lb.bastion_lb.arn}"
  port = 22
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.bastion_ssh_tg.arn}"
  }
}
