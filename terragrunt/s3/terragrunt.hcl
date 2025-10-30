include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=3.15.1"
}

inputs = {
  bucket                  = "mandos.net.pl"
  block_public_policy     = false
  block_public_acl        = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  website = {
    index_document = "index.html"
  }
}
