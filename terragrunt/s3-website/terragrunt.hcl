terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=3.15.1"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

include "aws" {
  path = find_in_parent_folders("provider_aws.hcl")
}

# NOTE: Only for secure access for CloudFront (not used for now)
# dependency "cloudfront" {
#   config_path = "../cloudfront/"
# }

inputs = {
  bucket        = include.root.locals.stack.apex_domain
  attach_policy = true

  # NOTE: Public access with webserver feature 
  block_public_policy     = false
  block_public_acl        = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  website = {
    index_document = "index.html"
  }
  policy = jsonencode(
    {
      Id = "Policy1397632521960"
      Statement = [
        {
          Sid = "Stmt1397633323327"
          Action = [
            "s3:GetObject"
          ]
          Effect   = "Allow"
          Resource = "arn:aws:s3:::${include.root.locals.stack.apex_domain}/*"
          Principal = {
            AWS = [
              "*"
            ]
          }
        }
      ]
    }
  )

  # NOTE: Only for secure access for CloudFront (not used for now)
  # block_public_policy     = true
  # block_public_acl        = true
  # ignore_public_acls      = true
  # restrict_public_buckets = true
  # policy = jsonencode({
  #   Version = "2008-10-17"
  #   Id      = "PolicyForCloudFrontPrivateContent",
  #   Statement = [
  #     {
  #       Sid    = "AllowCloudFrontServicePrincipal",
  #       Effect = "Allow",
  #       Principal = {
  #         Service = "cloudfront.amazonaws.com"
  #       },
  #       Action   = "s3:GetObject",
  #       Resource = "arn:aws:s3:::${include.root.locals.stack.apex_domain}/*",
  #       Condition = {
  #         StringEquals = {
  #           "AWS:SourceArn" = dependency.cloudfront.outputs.cloudfront_distribution_arn
  #         }
  #       }
  #     }
  #   ]
  # })

}
