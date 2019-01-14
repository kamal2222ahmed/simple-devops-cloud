### Set a Provider ###
provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.credentials_path}"
  profile                 = "${var.profile}"
}

### Get Data from Existing Resources ###
# Get Availability Zones
data "aws_availability_zones" "available" {}

# Get the Load Balancer Name
data "aws_elb" "selected" {
  name = "${var.project}-lb"
}

### Create and Validate SSL Certificate ###
# Create the Certificate
resource "aws_acm_certificate" "samuelnwoye_ssl" {
  domain_name       = "samuelnwoye.website"
  subject_alternative_names = ["www.samuelnwoye.website"]
  validation_method = "DNS"

  tags {
    Name   = "samuelnwoye-ssl"
    Domain = "samuelnwoye.website"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Validate the Certificate
resource "aws_acm_certificate_validation" "samuelnwoye_ssl" {
  certificate_arn = "${aws_acm_certificate.samuelnwoye_ssl.arn}"

  validation_record_fqdns = [
    "${aws_route53_record.samuelnwoye_cnssl.fqdn}",
    "${aws_route53_record.samuelnwoye_cnwwwssl.fqdn}"
  ]
}

### Configure DNS Services ###
# Samuel Nwoye Hosted Zones
resource "aws_route53_zone" "samuelnwoye" {
  name = "samuelnwoye.website"
  comment = "Samuel Nwoye Domain Name"
}

### Configure the Records ###
# Samuel Nwoye NS Record
resource "aws_route53_record" "samuelnwoye_ns" {
  zone_id = "${aws_route53_zone.samuelnwoye.zone_id}"
  name    = "samuelnwoye.website"
  type    = "NS"
  ttl     = "30"
  records = ["${slice(aws_route53_zone.samuelnwoye.name_servers,0,4)}"]
}

# Samuel Nwoye A Record
resource "aws_route53_record" "samuelnwoye_a" {
  zone_id = "${aws_route53_zone.samuelnwoye.zone_id}"
  name    = "samuelnwoye.website"
  type    = "A"
  alias {
    name                   = "${data.aws_elb.selected.dns_name}"
    zone_id                = "${data.aws_elb.selected.zone_id}"
    evaluate_target_health = true
  }
}

# Samuel Nwoye www CNAME Record
resource "aws_route53_record" "samuelnwoye_cnwww" {
  zone_id = "${aws_route53_zone.samuelnwoye.zone_id}"
  name    = "www.samuelnwoye.website"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 20
  }

  set_identifier = "www"
  records        = ["${aws_route53_record.samuelnwoye_a.name}"]
}

# Samuel Nwoye ssl CNAME Record
resource "aws_route53_record" "samuelnwoye_cnssl" {
  zone_id = "${aws_route53_zone.samuelnwoye.zone_id}"
  name    = "${aws_acm_certificate.samuelnwoye_ssl.domain_validation_options.0.resource_record_name}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 40
  }

  set_identifier = "ssl"
  records        = ["${aws_acm_certificate.samuelnwoye_ssl.domain_validation_options.0.resource_record_value}"]
}

# Samuel Nwoye www ssl CNAME Record
resource "aws_route53_record" "samuelnwoye_cnwwwssl" {
  zone_id = "${aws_route53_zone.samuelnwoye.zone_id}"
  name    = "${aws_acm_certificate.samuelnwoye_ssl.domain_validation_options.1.resource_record_name}"
  type    = "CNAME"
  ttl     = "5"

   weighted_routing_policy {
    weight = 40
  }

  set_identifier = "wwwssl"
  records        = ["${aws_acm_certificate.samuelnwoye_ssl.domain_validation_options.1.resource_record_value}"]
}