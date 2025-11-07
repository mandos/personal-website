terraform {
  source = "../modules/certificate/"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

include "aws" {
  path = find_in_parent_folders("provider_aws.hcl")
}

include "privider_cloudflare" {
  path = find_in_parent_folders("provider_cloudflare.hcl")
}

inputs = {
  domain_name = include.root.locals.stack.apex_domain

  subject_alternative_names = [
    include.root.locals.stack.additional_domain
  ]
}
