variable "rule_name" {
  description = "rule-name"
  type = sting
}

variable "schedule_expr" {
  description = "crone job"
  type = string
}

variable "lambda_function_arn" {
  description = "lambda function arn "
  type = string
}