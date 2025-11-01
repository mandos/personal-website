terraform {
  source = "../modules/certificate/"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "privider_cloudflare" {
  path = find_in_parent_folders("provider_cloudflare.hcl")
}

inputs = {
  domain_name = "mandos.net.pl"

  subject_alternative_names = [
    "*.mandos.net.pl",
  ]
}
