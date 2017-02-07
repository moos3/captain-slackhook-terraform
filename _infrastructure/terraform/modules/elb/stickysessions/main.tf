resource "aws_lb_cookie_stickiness_policy" "app" {
  name                     = "${var.vpc["tag"]}-elb-app-policy"
  load_balancer            = "${aws_elb.app.id}"
  lb_port                  = 443
  cookie_expiration_period = 960
}
