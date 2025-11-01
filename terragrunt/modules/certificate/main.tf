module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "6.1.1"

  domain_name = var.domain_name

  create_route53_records    = false
  zone_id                   = data.cloudflare_zone.this.zone_id
  validation_method         = "DNS"
  validation_record_fqdns   = [for name in cloudflare_dns_record.validation[*].name : trimsuffix(name, ".")]
  subject_alternative_names = var.subject_alternative_names
}

data "cloudflare_zone" "this" {
  filter = {
    name = var.domain_name
  }
}

resource "cloudflare_dns_record" "validation" {
  count = length(module.acm.distinct_domain_names)

  zone_id = data.cloudflare_zone.this.zone_id
  comment = "AWS certificate validation record"
  name    = trimsuffix(element(module.acm.validation_domains, count.index).resource_record_name, ".")
  type    = element(module.acm.validation_domains, count.index).resource_record_type
  content = trimsuffix(element(module.acm.validation_domains, count.index).resource_record_value, ".")
  ttl     = 86400
  proxied = false
}
