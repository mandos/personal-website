terraform {
  source = "../modules/dns/"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "provider_cloudfront" {
  path = find_in_parent_folders("provider_cloudflare.hcl")
}

dependency "cloudfront" {
  config_path = "../cloudfront"
}

inputs = {
  cloudfront_distribution_domain_name = dependency.cloudfront.outputs.cloudfront_distribution_domain_name
}
