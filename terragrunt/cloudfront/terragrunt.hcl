
terraform {
  source = "tfr:///terraform-aws-modules/cloudfront/aws?version=5.0.1"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "aws" {
  path = find_in_parent_folders("provider_aws.hcl")
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

  # Only for secure access to bucket (not used for now)
  create_origin_access_control = true
  origin_access_control = {
    s3_mandos_net_pl = {
      description      = "Access to S3 mandos.net.pl",
      origin_type      = "s3",
      signing_behavior = "always",
      signing_protocol = "sigv4"
    }
  }

  origin = {
    # Only for secure access to bucket (not used for now)
    s3_mandos_net_pl = {
      domain_name           = "mandos.net.pl.s3.eu-west-1.amazonaws.com"
      origin_access_control = "s3_mandos_net_pl"
    }

    # Public access by S3 Webserver feature
    s3_www_mandos_net_pl = {
      domain_name = "mandos.net.pl.s3-website-eu-west-1.amazonaws.com"

      custom_origin_config = {
        http_port                = 80
        https_port               = 443
        ip_address_type          = "ipv4"
        origin_keepalive_timeout = 5
        origin_protocol_policy   = "http-only"
        origin_read_timeout      = 30
        origin_ssl_protocols     = ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    # Only for secure access to bucket (not used for now)
    # target_origin_id = "s3_mandos_net_pl"
    # Public access by S3 Webserver feature
    target_origin_id = "s3_www_mandos_net_pl"

    viewer_protocol_policy = "redirect-to-https"
    use_forwarded_values   = false

    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true

    function_association = {
      viewer-request = {
        function_arn = "arn:aws:cloudfront::545927974903:function/index_redirection"
      }
    }
  }

  custom_error_response = {
    error_caching_min_ttl = 10
    error_code            = 403
    response_code         = 404
    response_page_path    = "/en/404.html"
  }

  viewer_certificate = {
    acm_certificate_arn      = dependency.certificate.outputs.acm.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Name = "personal-website"
  }
}
