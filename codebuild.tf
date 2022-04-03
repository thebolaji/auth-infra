resource "aws_codebuild_project" "authr_codebuild" {
  name         = "${local.env}_codebuild"
  description  = "CodeBuild for ${local.env}"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    # image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "REPOSITORY_URI"
      value = aws_ecr_repository.net.repository_url
    }
    
    environment_variable {
      name  = "TASK_DEFINITION"
      value = aws_ecs_task_definition.net_task_def.arn
    }

    environment_variable {
      name  = "CONTAINER_NAME"
      value = local.name
    }
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  tags = local.tags
}
