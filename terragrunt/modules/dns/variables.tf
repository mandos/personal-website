variable "apex_domain" {
  type        = string
  description = "Main domain for website"
}

variable "cloudfront_distribution_domain_name" {
  type        = string
  description = "Domain where apex domain should be redirected"
}
