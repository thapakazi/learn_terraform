provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

resource "aws_iam_role" "iam_for_lambdax" {
  name = "iam_for_lambdax"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "code.zip"
  function_name = "try_lambda"
  role          = "${aws_iam_role.iam_for_lambdax.arn}"
  handler       = "main.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("code.zip"))}"
  source_code_hash = "${filebase64sha256("code.zip")}"

  runtime = "nodejs12.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
