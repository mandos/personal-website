
terraform {
  source = "tfr:///terraform-aws-modules/cloudfront/aws?version=5.0.1"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "certificate" {
  config_path = "../certificate"
}

inputs = {
  aliases = ["mandos.net.pl", "www.mandos.net.pl"]

  comment             = "Because static html/css/js is too hard to handle by backend"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_200"
  retain_on_delete    = false
  wait_for_deployment = true

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }

  # logging_config = {
  #   bucket = "logs-my-cdn.s3.amazonaws.com"
  # }

  origin = {

    s3_one = {
      domain_name = "mandos.net.pl.s3-website-eu-west-1.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3_one"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }


  viewer_certificate = {
    acm_certificate_arn = dependency.certificate.outputs.acm.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}
