resource "aws_iam_role" "rabbitmq_logging_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "mq.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "rabbitmq_logging_policy" {
  name = var.iam_policy_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rabbitmq_logging_policy_attachment" {
  role       = aws_iam_role.rabbitmq_logging_role.name
  policy_arn = aws_iam_policy.rabbitmq_logging_policy.arn
}

output "iam_role_arn" {
  value = aws_iam_role.rabbitmq_logging_role.arn
}
