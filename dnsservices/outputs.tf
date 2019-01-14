output "dns_servers" {  
  value = "${aws_route53_zone.samuelnwoye.name_servers}"
}