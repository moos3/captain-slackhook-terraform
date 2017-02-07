data "template_file" "ecs" {
  template = "${file("${path.module}/files/ecs-node.sh")}"

  vars {
    registry            = "${var.options["registry"]}"
    hub_token           = "${var.options["hub_token"]}"
    slack_token         = "${var.options["slack_token"]}"
    hipchat_token       = "${var.options["hipchat_token"]}"
    auth_webhook_secret = "${var.options["auth_webhook_secret"]}"
    loggly_token        = "${var.options["loggly_token"]}"
  }
}

// AMIs by region for AWS Optimised Linux
data "aws_ami" "amazonlinux" {
  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
}

resource "aws_launch_configuration" "slackhook-node" {
  name_prefix   = "slackhook-bot-"
  image_id      = "${data.aws_ami.amazonlinux.image_id}"
  image_id      = "${lookup(var.images, var.options["region"])}"
  instance_type = "${var.options["amisize"]}"

  //  security_groups             = ["${var.security_groups}"]
  security_groups             = ["${aws_security_group.docker-nodes.id}"]
  iam_instance_profile        = "${aws_iam_instance_profile.bot.name}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = false
  user_data                   = "${data.template_file.ecs.rendered}"
}

resource "aws_autoscaling_group" "slackhook-cluster" {
  name                 = "slackhook"
  min_size             = "${var.options["autoscale_min"]}"
  max_size             = "${var.options["autoscale_max"]}"
  desired_capacity     = "${var.options["autoscale_desired_cap"]}"
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.slackhook-node.name}"
  availability_zones   = "${split(",", lookup(var.azs, var.options["region"]))}"
  vpc_zone_identifier  = ["${var.subnets}"]
  load_balancers       = ["${var.load_balancers}"]

  tag {
    key                 = "Name"
    value               = "Slackbook Node"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "slackbot cluster"
    propagate_at_launch = true
  }
}
