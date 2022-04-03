resource "aws_ecr_repository" "net" {
  name = "net"
  image_scanning_configuration {
    scan_on_push = false
  }
}