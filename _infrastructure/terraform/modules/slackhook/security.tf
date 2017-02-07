resource "aws_security_group" "docker-nodes" {
  name        = "${lower(var.options["tag"])}-docker-nodes"
  description = "Allows 80 from the world and all traffic from private nets"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${var.security_groups}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.options["tag"]}-docker-node"
    Environment = "${lower(var.options["tag"])}"
  }
}
