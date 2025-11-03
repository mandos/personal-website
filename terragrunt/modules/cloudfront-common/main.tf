resource "aws_cloudfront_function" "index_html_redirection" {
  name    = "index_html_redirection"
  runtime = "cloudfront-js-2.0"
  comment = "If request path finish with xxx/ redirect to xxx/index.html"
  publish = true
  code    = file("${path.module}/index_html_redirection.js")
}

data "aws_cloudfront_cache_policy" "managed_cachingoptimized" {
  name = "Managed-CachingOptimized"
}
