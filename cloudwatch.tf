resource "aws_cloudwatch_log_group" "net_log_group" {
  name = local.name
  tags = local.tags
}