/*=== AUTOSCALING NOTIFICATIONS ===*/
resource "aws_autoscaling_notification" "main" {
  group_names = [
    "${aws_autoscaling_group.nat.name}",
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = "${aws_sns_topic.main.arn}"
}

resource "aws_sns_topic" "main" {
  name = "${lower(var.vpc["tag"])}-sns-topic"

  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.vpc["sns_email"]}"
  }
}
