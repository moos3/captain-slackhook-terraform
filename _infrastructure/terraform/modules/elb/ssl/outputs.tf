output "elb-app-public-dns" {
  value = "${aws_elb.app.dns_name}"
}

output "elb-app-name" {
  value = "${aws_elb.app.name}"
}
