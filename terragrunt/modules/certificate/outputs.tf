output "acm" {
  value = module.acm
}

output "cloudflare_dns_records" {
  value = cloudflare_dns_record.validation
}
