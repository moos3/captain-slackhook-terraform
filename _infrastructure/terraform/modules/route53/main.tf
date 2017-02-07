resource "aws_route53_record" "${var.dns["project_name"]}" {
  zone_id = "${var.dns["zone_id"]}"
  name    = "${lower(var.dns["record_name"])}"
  type    = "${upper(var.dns["record_type"])}"
  ttl     = "${var.dns["ttl"]}"
  records = ["${var.dns["hostname"]}"]
}
