resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.function_name}_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambda" {
  function_name    = var.function_name
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)
  memory_size      = var.memory_size
  timeout          = var.timeout
}