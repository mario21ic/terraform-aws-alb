output "id" {
  value = "${aws_lb.my_alb.*.id}"
}

output "dns_name" {
  value = "${aws_lb.my_alb.*.dns_name}"
}

//output "security_group_id" {
//  value = "${aws_security_group.my_sg.id}"
//}

output "zone_id" {
  value = "${aws_lb.my_alb.*.zone_id}"
}

//output "ssl_extras" {
//  value = "${local.ssl_arn_extras}"
//}

