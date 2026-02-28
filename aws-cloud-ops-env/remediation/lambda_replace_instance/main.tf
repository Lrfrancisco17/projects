resource "aws_lambda_function" "this" {
  function_name = var.name
  handler       = "main.lambda_handler"
  runtime       = "python3.12"
  role          = var.lambda_role_arn

  filename         = "${path.module}/package.zip"
  source_code_hash = filebase64sha256("${path.module}/package.zip")

  timeout = 30
}

