/*== ELB ==*/
resource "aws_elb" "app" {
  /* Requiered for EC2 ELB only
                                          availability_zones = "${var.zones}"
                                          */

  name = "${var.options["tag"]}-elb-${var.options["app_name"]}"

  subnets         = ["${var.options["subnets"]}"]
  security_groups = ["${var.options["elb_security_group"]}"]

  listener {
    instance_port     = "${var.options["listen_port_http"]}"
    instance_protocol = "${var.options["listen_protocol"]}"
    lb_port           = "${var.options["lb_port"]}"
    lb_protocol       = "${var.options["lb_protocol"]}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    target              = "${var.options["hc_protocol"]}:${var.options["listen_port_http"]}${var.options["elb_hc_uri"]}"
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
