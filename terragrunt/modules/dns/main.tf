locals {
  domain_name = "mandos.net.pl"
}

data "cloudflare_zone" "this" {
  filter = {
    name = local.domain_name
  }
}

resource "cloudflare_dns_record" "main" {
  zone_id = data.cloudflare_zone.this.zone_id
  comment = "Redirect to AWS CloudFront"
  name    = local.domain_name
  type    = "CNAME"
  content = var.cloudfront_distribution_domain_name
  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "www" {
  zone_id = data.cloudflare_zone.this.zone_id
  comment = "Redirect to mandos.net.pl"
  name    = "www"
  type    = "CNAME"
  content = local.domain_name
  ttl     = 1
  proxied = false
}
