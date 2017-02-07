module "slackhook_elb" {
  source = "./_infrastructure/terraform/modules/elb/nonssl"

  options = {
    tag                = "${var.vpc["tag"]}"
    app_name           = "slackhook-api"
    subnets            = "${split(",", module.bot-vpc.private-subnet-ids)}"
    elb_security_group = "${module.bot-vpc.security-group-elb}"
    listen_port_http   = 80
    listen_protocol    = "http"
    lb_port            = 80
    lb_protocol        = "http"
    hc_protocol        = "http"
    elb_hc_uri         = "/"
  }

  provider = "aws.dev"
}

module "thegeneral_elb" {
  source = "./_infrastructure/terraform/modules/elb/nonssl"

  options = {
    tag                = "${var.vpc["tag"]}"
    app_name           = "thegeneral-api"
    subnets            = "${split(",", module.bot-vpc.private-subnet-ids)}"
    elb_security_group = "${module.bot-vpc.security-group-elb}"
    listen_port_http   = 80
    listen_protocol    = "http"
    lb_port            = 80
    lb_protocol        = "http"
    hc_protocol        = "http"
    elb_hc_uri         = "/"
  }

  provider = "aws.dev"
}

module "slackhook" {
  source          = "./_infrastructure/terraform/modules/slackhook"
  vpc_id          = "${module.bot-vpc.vpc-id}"
  subnets         = "${split(",", module.bot-vpc.private-subnet-ids)}"
  load_balancers  = "${module.slackhook_elb.elb-name}"
  options         = "${var.slackhook}"
  key_name        = "${var.setup["key_name"]}"
  security_groups = ["${module.bot-vpc.security-group-private}", "${module.bot-vpc.security-group-private-2}"]
  provider        = "aws.dev"
}

module "thegeneral" {
  source          = "./_infrastructure/terraform/modules/bot"
  vpc_id          = "${module.bot-vpc.vpc-id}"
  subnets         = "${split(",", module.bot-vpc.private-subnet-ids)}"
  load_balancers  = "${module.thegeneral_elb.elb-name}"
  options         = "${var.thegeneral}"
  key_name        = "${var.setup["key_name"]}"
  security_groups = ["${module.bot-vpc.security-group-private}", "${module.bot-vpc.security-group-private-2}"]
  provider        = "aws.dev"
}
