data "cloudflare_zone" "this" {
  filter = {
    name = var.apex_domain
  }
}

resource "cloudflare_dns_record" "main" {
  zone_id = data.cloudflare_zone.this.zone_id
  comment = "Redirect to AWS CloudFront"
  name    = var.apex_domain
  type    = "CNAME"
  content = var.cloudfront_distribution_domain_name
  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "www" {
  zone_id = data.cloudflare_zone.this.zone_id
  comment = "Redirect to ${var.apex_domain}"
  name    = "www"
  type    = "CNAME"
  content = var.apex_domain
  ttl     = 1
  proxied = false
}
