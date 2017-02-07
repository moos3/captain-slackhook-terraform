/*== ELB ==*/
resource "aws_elb" "app" {
  /* Requiered for EC2 ELB only
                                availability_zones = "${var.zones}"
                                */
  name = "${var.options["tag"]}-elb-${var.options["app_name"]}"

  subnets         = ["${var.options["subnets"]}"]
  security_groups = ["${var.options["elb_security_group"]}"]

  listener {
    instance_port      = "${var.options["listen_port_http"]}"
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${var.options["elb_ssl_cert_arn"]}"
  }

  listener {
    instance_port     = "${var.options["listen_port_http"]}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    target              = "HTTP:${var.options["listen_port_http"]}${var.options["elb_hc_uri"]}"
    interval            = 10
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 960  # set it higher than the conn. timeout of the backend servers
  connection_draining         = true
  connection_draining_timeout = 300

  tags {
    Name = "${var.options["tag"]}-elb-${var.options["app_name"]}"
    Type = "elb"
  }
}
