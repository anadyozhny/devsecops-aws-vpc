
# File:
#  - modules/ec2/launch_configurations.tf

resource "aws_launch_configuration" "bastion_host_lc" {
  name = "Bastion-Host-VPC1-LC"
  image_id = "${var.ami_amazon_linux_2}"
  instance_type = "t2.micro"
  security_groups = [ "${aws_security_group.bastion_sg_vpc1.id}" ]
  key_name = "${var.key_pair}"
  iam_instance_profile = "${var.iam_role_bastion}"
  user_data = "${file("files/user_data_bastion.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "internal_host_lc" {
  name = "Internal-Host-VPC2-LC"
  image_id = "${var.ami_amazon_linux_2}"
  instance_type = "t2.micro"
  security_groups = [ "${aws_security_group.internal_sg_vpc2.id}" ]
# key_name = "${var.key_pair}"

  lifecycle {
    create_before_destroy = true
  }
}
