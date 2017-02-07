data "template_file" "bot-node" {
  template = "${file("${path.module}/files/bot-node.sh")}"

  vars {
    bot_container_registry = "${var.options["container_registry"]}"
    bot_image_tag          = "${var.options["container_image_tag"]}"
    bot_envs               = "${var.options["container_args"]}"
    bot_ports              = "${var.options["container_ports"]}"
    bot_image_name         = "${var.options["container_name"]}"
    hub_token              = "${var.options["hub_token"]}"
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

resource "aws_launch_configuration" "bot-node" {
  name_prefix   = "${var.options["name_prefix"]}"
  image_id      = "${data.aws_ami.amazonlinux.image_id}"
  image_id      = "${lookup(var.images, var.options["region"])}"
  instance_type = "${var.options["amisize"]}"

  //  security_groups             = ["${var.security_groups}"]
  security_groups             = ["${aws_security_group.docker-nodes.id}"]
  iam_instance_profile        = "${aws_iam_instance_profile.bot.name}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = false
  user_data                   = "${data.template_file.bot-node.rendered}"
}

resource "aws_autoscaling_group" "bot-asg" {
  name                 = "${var.options["project_name"]}"
  min_size             = "${var.options["autoscale_min"]}"
  max_size             = "${var.options["autoscale_max"]}"
  desired_capacity     = "${var.options["autoscale_desired_cap"]}"
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.bot-node.name}"
  availability_zones   = "${split(",", lookup(var.azs, var.options["region"]))}"
  vpc_zone_identifier  = ["${var.subnets}"]
  load_balancers       = ["${var.load_balancers}"]

  tag {
    key                 = "Name"
    value               = "${var.options["tag"]} Node"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "${var.options["tag"]} ASG"
    propagate_at_launch = true
  }
}
