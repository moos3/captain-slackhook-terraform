/*== NAT INSTANCE IAM PROFILE ==*/
resource "aws_iam_instance_profile" "bot" {
  name  = "${var.options["tag"]}-nat-profile"
  roles = ["${aws_iam_role.bot.name}"]
}

resource "aws_iam_role" "bot" {
  name = "${var.options["tag"]}-bot-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {"AWS": "*"},
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "bot" {
  name        = "${var.options["tag"]}-bot-policy"
  path        = "/"
  description = "BOT IAM policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:ModifyInstanceAttribute",
                "ec2:DescribeSubnets",
                "ec2:DescribeRouteTables",
                "ec2:CreateRoute",
                "ec2:ReplaceRoute"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "bot" {
  name       = "${var.options["tag"]}-bot-attachment"
  roles      = ["${aws_iam_role.bot.name}"]
  policy_arn = "${aws_iam_policy.bot.arn}"
}
