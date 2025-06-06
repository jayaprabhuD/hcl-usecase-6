module "iam" {
  source           = "./modules/iam"
  lambda_role_name = "ec2-lambda-role-for-stop-start"
}


module "start_lambda" {
  source           = "./modules/lambda"
  function_name    = "StartEC2Instances"
  handler_file     = "${path.module}/start_lambda.py"
  handler_name     = "start_lambda.lambda_handler"
  role_arn         = module.iam.lambda_role_arn
  environment_vars = {
    INSTANCE_IDS = "i-05912e307dea646aa"
  }
}

module "stop_lambda" {
  source           = "./modules/lambda"
  function_name    = "StopEC2Instances"
  handler_file     = "${path.module}/stop_lambda.py"
  handler_name     = "stop_lambda.lambda_handler"
  role_arn         = module.iam.lambda_role_arn
  environment_vars = {
    INSTANCE_IDS = "i-05912e307dea646aa"
  }
}

# stop cron scheduler

module "stop_scheduler" {
  source              = "./modules/cw_event"
  rule_name           = "StopEC2InstancesRule"
  schedule_expr       =  "cron(0 18 ? * MON-FRI *)" 
  lambda_function_arn = module.stop_lambda.lambda_role_arn
}

# start cron scheduler
module "start_scheduler" {
  source              = "./modules/cw_event"
  rule_name           = "StartEC2InstancesRule"
  schedule_expr       = "cron(0 18 ? * MON-FRI *)" 
  lambda_function_arn = module.start_lambda.lambda_role_arn
}