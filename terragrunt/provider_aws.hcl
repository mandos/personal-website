locals {
  region = try(yamldecode(file("${get_original_terragrunt_dir()}/region.yaml")).region, "eu-west-1")
}

generate "aws" {
  path      = "auto-aws.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.region}"
  default_tags {
    tags = {
      "Terraform" = "true"
      "App" = "personal-website"
    }
  }
}
EOF
}
