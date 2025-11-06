data "aws_caller_identity" "current" {}

resource "aws_budgets_budget" "monthly" {
  name              = "Monthly"
  budget_type       = "COST"
  limit_amount      = "5"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2017-07-01_00:00"
  time_unit         = "MONTHLY"
  billing_view_arn  = "arn:aws:billing::${data.aws_caller_identity.current.account_id}:billingview/primary"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["marek.maksimczyk+aws@mandos.net.pl"]
  }
}
