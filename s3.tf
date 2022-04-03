resource "aws_s3_bucket" "auth_bucket" {
  bucket = var.auth_bucket_name
}

# resource "aws_s3_bucket_object" "dist_item" {
#   key    = "${local.env}/dist-${uuid()}"
#   bucket = "${aws_s3_bucket.auth_bucket.id}"
#   source = "${var.dist_zip}"
# }

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "xcodepipeline-bucket"
  # acl           = "private"
  force_destroy = true
}

# resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
#   bucket = aws_s3_bucket.codepipeline_bucket.id
#   acl    = "private"
# }


# Create s3 bucket to store my docker run config
# resource "aws_s3_bucket" "docker_run_bucket" {
#   bucket = "docker-run-bucket"
#   acl    = "private"

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }

#   tags = local.tags
# }

# # Create s3 object from the compressed docker run config
# resource "aws_s3_bucket_object" "docker_run_object" {
#   key    = "${local.docker_run_config_sha}.zip"
#   bucket = aws_s3_bucket.docker_run_bucket.id
#   source = data.archive_file.docker_run.output_path
#   tags   = local.tags
# }
