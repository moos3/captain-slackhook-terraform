output "elb-app-public-dns" {
  value = "${aws_elb.app.dns_name}"
}

output "elb-name" {
  value = "${aws_elb.app.name}"
}
