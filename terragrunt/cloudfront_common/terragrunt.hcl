terraform {
  source = "../modules/cloudfront-common/"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "aws" {
  path = find_in_parent_folders("provider_aws.hcl")
}
