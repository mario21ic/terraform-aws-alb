resource "aws_lb" "my_alb" {
  name               = "${var.env}-alb-${var.name}"
  internal           = "${var.internal}"
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.my_sg.id}"]
  subnets            = ["${var.subnet_ids}"]

  enable_deletion_protection = false

  tags {
    Env         = "${var.env}"
    Description = "ALB ${var.env} ${var.name}"
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = "${aws_lb.my_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.my_tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "my_tg" {
  name     = "${var.env}-tg-${var.name}"
  target_type = "instance"

  vpc_id   = "${var.vpc_id}"
  protocol = "HTTP"
  port     = 80

  health_check {
    protocol = "HTTP"
    path = "${var.health_check_path}"
    port = "traffic-port"
    healthy_threshold = 8
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    matcher = "200"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "${var.env}-sg-alb-${var.name}"
  description = "Autoscaling inbound and outbound"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Env         = "sg-lb-${var.env}"
    Description = "Security group of ${var.env}"
  }
}
