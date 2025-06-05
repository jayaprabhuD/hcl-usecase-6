variable "rule_name" {
  description = "rule-name"
  type = string
}

variable "schedule_expr" {
  description = "cron job"
  type = string
}

variable "lambda_function_arn" {
  description = "lambda function arn "
  type = string
}