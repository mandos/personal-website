terraform {
  source = "tfr:///terraform-aws-modules/acm/aws?version=6.1.1"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  domain_name = "mandos.net.pl"

  validation_method      = "DNS"
  create_route53_records = false

  subject_alternative_names = [
    "*.mandos.net.pl",
  ]
}
