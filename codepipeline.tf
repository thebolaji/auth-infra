resource "aws_codepipeline" "codepipeline" {
  name     = "authr-codepipe"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.auth_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.authr_codestar_connection
        FullRepositoryId = "BigB97/auth-athur"
        BranchName       = "master"
        # OutputFilePath   = "CODE_PIPELINE_FILE"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.authr_codebuild.name
      }
    }
  }

 stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      version         = "1"
      run_order       = 1
      input_artifacts = ["build_output"]

      configuration = {
        ApplicationName                = local.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.group.deployment_group_name
        AppSpecTemplateArtifact        = "build_output"
        AppSpecTemplatePath            = "appspec.yaml"
        TaskDefinitionTemplateArtifact = "build_output"
        TaskDefinitionTemplatePath     = "taskdef.json"
      }
    }
  }

# deploy to elasticbeanstalk
  # stage {
  #   name = "Deploy"

  #   action {
  #     name             = "Deploy"
  #     category         = "Deploy"
  #     owner            = "AWS"
  #     provider         = "ElasticBeanstalk"
  #     version          = "1"
  #     input_artifacts  = ["build_output"]
      
  #     configuration = {
  #       ApplicationName = aws_elastic_beanstalk_application.auther-elastic-beanstalk-app.name
  #       EnvironmentName = aws_elastic_beanstalk_environment.auther-elastic-beanstalk-env.name
  #     }
  #   }
  # }

}