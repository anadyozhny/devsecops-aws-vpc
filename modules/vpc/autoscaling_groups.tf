# File:
#  - modules/ec2/autoscaling_groups.tf

resource "aws_autoscaling_group" "bastion_host_asg" {
  name = "Bastion-Host-VPC1-ASG"
  launch_configuration = "${aws_launch_configuration.bastion_host_lc.name}"
  desired_capacity = 1
  min_size = 1
  max_size = 1
  vpc_zone_identifier = "${aws_subnet.public_subnets_vpc1.*.id}"
  target_group_arns = ["${aws_lb_target_group.bastion_ssh_tg.arn}"]

  tags = [
    {
      key = "Name"
      value = "Bastion"
      propagate_at_launch = true
    },
    {
      key = "Tier"
      value = "Public"
      propagate_at_launch = true
    },
    {
      key = "Task"
      value = "DevSecOps-AWS"
      propagate_at_launch = true
    },
    {
      key = "Tool"
      value = "Terraform"
      propagate_at_launch = true
    }
  ]
}


resource "aws_autoscaling_group" "internal_host_asg" {
  name = "Internal-Host-VPC2-ASG"
  launch_configuration = "${aws_launch_configuration.internal_host_lc.name}"
  desired_capacity = 2
  min_size = 1
  max_size = 3
  vpc_zone_identifier = "${aws_subnet.private_subnets_vpc2.*.id}"
  tags = [
    {
      key = "Name"
      value = "Internal"
      propagate_at_launch = true
    },
    {
      key = "Tier"
      value = "Private"
      propagate_at_launch = true
    },
    {
      key = "Task"
      value = "DevSecOps-AWS"
      propagate_at_launch = true
    },
    {
      key = "Tool"
      value = "Terraform"
      propagate_at_launch = true
    }
  ]
}
