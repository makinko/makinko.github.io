provider "aws" {
  region = "ap-northeast-1"
}

module "lambda_function" {
  source        = "../../modules/lambda_function"
  env           = var.env
  function_name = var.function_name
  runtime       = var.runtime
  handler       = var.handler
  memory_size   = var.memory_size
  timeout       = var.timeout
  filename      = var.filename
}