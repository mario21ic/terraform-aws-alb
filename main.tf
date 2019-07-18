resource "aws_lb" "my_alb" {
  count = "${var.target_group_qty}"

  name               = "${var.env}-alb-${var.name}-${count.index}"
  internal           = "${var.internal}"
  load_balancer_type = "application"
  security_groups    = ["${var.security_group_ids}"]
  subnets            = ["${var.subnet_ids}"]

  enable_deletion_protection = false
  idle_timeout = "${var.timeout}"

  //  access_logs {
  //    bucket  = "${aws_s3_bucket.lb_logs.bucket}"
  //    prefix  = "test-lb"
  //    enabled = true
  //  }

  tags {
    Env         = "${var.env}"
    Description = "ALB ${var.env} ${var.name}"
  }
}

resource "aws_lb_listener" "listener_http" {
  count = "${var.target_group_qty}"

  load_balancer_arn = "${element(aws_lb.my_alb.*.arn, count.index)}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${element(var.target_group_arns, count.index)}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "listener_https" {
  count = "${var.ssl_qty}"

  load_balancer_arn = "${element(aws_lb.my_alb.*.arn, count.index)}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${element(var.ssl_arns, count.index)}"

  default_action {
    target_group_arn = "${element(var.target_group_arns, count.index)}"
    type             = "forward"
  }
}

# Maximum 25 without default
resource "aws_lb_listener_certificate" "extras" {
  count = "${var.target_group_qty * var.ssl_extras_qty}"

  listener_arn    = "${element(aws_lb_listener.listener_https.*.arn, count.index)}"
  certificate_arn = "${element(var.ssl_extras_arns, count.index)}"
}
