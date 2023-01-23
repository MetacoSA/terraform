# Refer to an existing root domain
data "aws_route53_zone" "root_domain" {
  name  = var.aws_dns_root_domain
}

# Create DNS_A record under the root domain. This serves as root domain for the Harmonize
# Only create if there is a non default value
resource "aws_route53_record" "dns_a_harmonize_root_domain" {
  count   = (length(var.ingress_ctrl_ip_address) == 0) ? 0 : 1
  zone_id = data.aws_route53_zone.root_domain.zone_id
  name    = format("%s.%s", var.harmonize_domain_prefix,
                   data.aws_route53_zone.root_domain.name)
  type    = "A"
  ttl     = "3600"
  records = var.ingress_ctrl_ip_address
}

# Create DNS_A record under the root domain. This serves as sub domain for the Harmonize 
# Only create if there is a non default value
resource "aws_route53_record" "dns_a_harmonize_sub_domain" {
  count   = (length(var.ingress_ctrl_ip_address) == 0) ? 0 : 1
  zone_id = data.aws_route53_zone.root_domain.zone_id
  name    = format("*.%s.%s", var.harmonize_domain_prefix,
                   data.aws_route53_zone.root_domain.name)
  type    = "A"
  ttl     = "3600"
  records = var.ingress_ctrl_ip_address
}

# Create DNS_CNAME record under the root domain. This serves as root domain for the Harmonize
# Only create if there is a non default value
resource "aws_route53_record" "dns_cname_harmonize_root_domain" {
  count   = (length(var.ingress_ctrl_hostname) == 0) ? 0 : 1
  zone_id = data.aws_route53_zone.root_domain.zone_id
  name    = format("%s.%s", var.harmonize_domain_prefix,
                   data.aws_route53_zone.root_domain.name)
  type    = "CNAME"
  ttl     = "3600"
  records = var.ingress_ctrl_hostname
}

# Create DNS_CNAME record under the root domain. This serves as sub domain for the Harmonize 
# Only create if there is a non default value
resource "aws_route53_record" "dns_cname_harmonize_sub_domain" {
  count   = (length(var.ingress_ctrl_hostname) == 0) ? 0 : 1
  zone_id = data.aws_route53_zone.root_domain.zone_id
  name    = format("*.%s.%s", var.harmonize_domain_prefix,
                   data.aws_route53_zone.root_domain.name)
  type    = "CNAME"
  ttl     = 3600
  records = var.ingress_ctrl_hostname
}
