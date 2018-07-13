output "load_balancer_id" {
  value = "${aws_lb.my_alb.id}"
}

output "load_balancer_dns_name" {
  value = "${aws_lb.my_alb.dns_name}"
}

output "security_group_id" {
  value = "${aws_security_group.my_sg.id}"
}

output "load_balancer_zone_id" {
  value = "${aws_lb.my_alb.zone_id}"
}

