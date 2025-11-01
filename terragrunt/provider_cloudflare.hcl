generate "cloudflare" {
  path      = "auto-cloudflare.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "cloudflare" {
#  api_token = var.cloudflare_api_token
}
EOF
}

