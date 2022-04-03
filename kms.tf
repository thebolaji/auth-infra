resource "aws_kms_key" "kms_key" {
  description             = "net_kms_key"
  deletion_window_in_days = 7
}