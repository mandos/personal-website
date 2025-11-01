include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../modules/dns/"
}

dependency "cloudfront" {
  config_path = "../cloudfront"
}

inputs = {
  cloudfront_distribution_domain_name = dependency.cloudfront.outputs.cloudfront_distribution_domain_name
}
