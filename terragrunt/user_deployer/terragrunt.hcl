terraform {
  source = "tfr:///terraform-aws-modules/iam/aws//modules/iam-user?version=6.2.3"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  name = "private-website.deployer"

  force_destroy        = false
  create_login_profile = false
  crete_access_key     = true

}
