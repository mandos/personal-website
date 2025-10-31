terraform {
  source = "tfr:///terraform-aws-modules/iam/aws//modules/iam-user?version=6.2.3"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "cloudfront" {
  config_path = "../cloudfront"
}

dependency "s3"  {
  config_path = "../s3"
}

inputs = {
  name = "private-website.deployer"

  force_destroy        = false
  create_login_profile = false
  crete_access_key     = true

  create_inline_policy = true
  inline_policy_permissions = {
    S3Sync = {
      effect = "Allow"
      actions = [
        "s3:ListBucket",
        "s3:PutObject",
        "s3:DeleteObject",
      ]
      resources = [
        "${dependency.s3.outputs.s3_bucket_arn}",
        "${dependency.s3.outputs.s3_bucket_arn}/*",
      ]
    }
    CloudFrontInvalidation = {
      effect = "Allow"
      actions = [
        "cloudfront:CreateInvalidation",
      ]
      resources = [
        dependency.cloudfront.outputs.cloudfront_distribution_arn
      ]
    }
  }
}
