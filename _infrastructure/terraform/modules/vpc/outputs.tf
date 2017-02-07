/*=== OUTPUTS ===*/
output "num-zones" {
  value = "${length(lookup(var.azs, var.provider[region]))}"
}

output "vpc-id" {
  value = "${aws_vpc.environment.id}"
}

output "public-subnet-ids" {
  value = "${join(",", aws_subnet.public-subnets.*.id)}"
}

output "private-subnet-ids" {
  value = "${join(",", aws_subnet.private-subnets.*.id)}"
}

output "private-subnet-2-ids" {
  value = "${join(",", aws_subnet.private-subnets-2.*.id)}"
}

output "autoscaling_notification_sns_topic" {
  value = "${aws_sns_topic.main.id}"
}

output "security-group-private" {
  value = "${aws_security_group.private.id}"
}

output "security-group-private-2" {
  value = "${aws_security_group.private-2.id}"
}

output "security-group-public" {
  value = "${aws_security_group.public.id}"
}

output "security-group-nat" {
  value = "${aws_security_group.private.id}"
}

output "security-group-elb" {
  value = "${aws_security_group.elb.id}"
}

output "security-group-default" {
  value = "${aws_security_group.default.id}"
}
