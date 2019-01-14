output "asg_name" {
  value = "${aws_autoscaling_group.simple_devops_asg.name}"
}

output "lb_dns_name" {
  value = "${aws_elb.samuelnwoye_lb.dns_name}"
}

