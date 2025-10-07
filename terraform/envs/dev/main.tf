provider "aws" {
  region = "ap-northeast-1"
}

module "lambda_function" {
  source              = "../../modules/lambda_function"
  env                 = var.env
  function_name       = var.function_name
  runtime             = var.runtime
  handler             = var.handler
  filename            = var.filename
  memory_size         = var.memory_size
  timeout             = var.timeout
  dynamodb_table_name = module.dynamodb_tenant.dynamodb_table_name
}

module "dynamodb_tenant" {
  source        = "../../modules/dynamodb_tenant"
  env           = var.env
  project_name  = var.project_name
  table_name    = var.table_name
}
