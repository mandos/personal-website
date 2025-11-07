terraform {
  source = "../modules/dns/"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

include "provider_cloudfront" {
  path = find_in_parent_folders("provider_cloudflare.hcl")
}

dependency "cloudfront" {
  config_path = "../cloudfront"
}

inputs = {
  apex_domain = include.root.locals.stack.apex_domain
  cloudfront_distribution_domain_name = dependency.cloudfront.outputs.cloudfront_distribution_domain_name
}
