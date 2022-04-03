output "aws_azs" {
  value = aws_subnet.net_public[0].availability_zone
}

output "aws_ecr" {
  value = aws_ecr_repository.net
}

