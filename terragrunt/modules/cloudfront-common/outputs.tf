output "function_arns" {
  value ={
    index_html_redirection = aws_cloudfront_function.index_html_redirection.arn
  }
}

output "caching_policies_ids" {
  value = {
  managed_cachingoptimized = data.aws_cloudfront_cache_policy.managed_cachingoptimized.id
  }
}
