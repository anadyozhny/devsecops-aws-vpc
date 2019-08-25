# File:
#  - modules/vpc/route53_record.tf

data "aws_route53_zone" "me" {
  name = "nadyozhny.me."
}

resource "aws_route53_record" "bastion" {
  zone_id = "${data.aws_route53_zone.me.zone_id}"
  name = "bastion"
  type = "A"
  allow_overwrite = true

  alias {
    name = "${aws_lb.bastion_lb.dns_name}"
    zone_id = "${aws_lb.bastion_lb.zone_id}"
    evaluate_target_health = true
  }
}
