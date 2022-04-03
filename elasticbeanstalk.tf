# resource "aws_elastic_beanstalk_application" "auther-elastic-beanstalk-app" {
#   name        = "authrrr-ebs-app"

#   appversion_lifecycle {
#     service_role          = aws_iam_role.elasticbeanstalk_service.arn
#     max_count             = 128
#     delete_source_from_s3 = true
#   }
# }

# resource "aws_elastic_beanstalk_environment" "auther-elastic-beanstalk-env" {
#   name = "authrr-ebs-env"

#   application = aws_elastic_beanstalk_application.auther-elastic-beanstalk-app.name
#   solution_stack_name = "64bit Amazon Linux 2 v3.4.12 running Docker"
#   tier                = "WebServer"

#   #  setting {
#   #   namespace = "aws:autoscaling:launchconfiguration"
#   #   name      = "IamInstanceProfile"
#   #   value     =  "aws-elasticbeanstalk-ec2-role"
#   # }

#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "InstanceType"
#     value     = "t2.micro"
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:environment"
#     name      = "ServiceRole"
#     value     = "aws-elasticbeanstalk-service-role"
#   }

#   # setting {
#   #   namespace = "aws:elasticbeanstalk:environment"
#   #   name      = "EnvironmentType"
#   #   value     = "LoadBalanced"
#   # }

#   #  setting {
#   #   namespace = "aws:autoscaling:asg"
#   #   name      = "MinSize"
#   #   value     = 1
#   # }
#   # setting {
#   #   namespace = "aws:autoscaling:asg"
#   #   name      = "MaxSize"
#   #   value     = 4
#   # }
#   # setting {
#   #   namespace = "aws:elasticbeanstalk:healthreporting:system"
#   #   name      = "SystemType"
#   #   value     = "enhanced"
#   # }

#   # setting {
#   #   namespace = "aws:autoscaling:updatepolicy:rollingupdate"
#   #   name      = "RollingUpdateEnabled"
#   #   value     = true
    
#   # }

#   # setting {
#   #   namespace = "aws:autoscaling:updatepolicy:rollingupdate"
#   #   name      = "RollingUpdateType"
#   #   value     = "Health"
    
#   # }

#   # setting {
#   #   namespace = "aws:autoscaling:updatepolicy:rollingupdate"
#   #   name      = "MinInstancesInService"
#   #   value     = 1
    
#   # }
#   #   setting {
#   #   namespace = "aws:elb:loadbalancer"
#   #   name = "CrossZone"
#   #   value = "true"
#   # }
#   # setting {
#   #   namespace = "aws:elasticbeanstalk:command"
#   #   name      = "DeploymentPolicy"
#   #   value     = "RollingWithAdditionalBatch"
    
#   # }
  
#   # setting {
#   #   namespace = "aws:elasticbeanstalk:command"
#   #   name = "BatchSize"
#   #   value = "30"
#   # }
#   # setting {
#   #   namespace = "aws:elasticbeanstalk:command"
#   #   name = "BatchSizeType"
#   #   value = "Percentage"
#   # }

#   # setting {
#   #   namespace = "aws:autoscaling:updatepolicy:rollingupdate"
#   #   name      = "MaxBatchSize"
#   #   value     = 1
#   # }
#   #  ###=========================== Logging ========================== ###

#   # setting {
#   #   namespace = "aws:elasticbeanstalk:hostmanager"
#   #   name      = "LogPublicationControl"
#   #   value     = false
    
#   # }

#   # setting {
#   #   namespace = "aws:elasticbeanstalk:cloudwatch:logs"
#   #   name      = "StreamLogs"
#   #   value     = true
    
#   # }

#   # setting {
#   #   namespace = "aws:elasticbeanstalk:cloudwatch:logs"
#   #   name      = "DeleteOnTerminate"
#   #   value     = true
    
#   # }

#   # setting {
#   #   namespace = "aws:elasticbeanstalk:cloudwatch:logs"
#   #   name      = "RetentionInDays"
#   #   value     = 7
    
#   # }
#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "PORT"
#     value     = "3000"
#   }
  
# }



# # resource "aws_elastic_beanstalk_application_version" "ebs-app-ver" {
# #   depends_on = [aws_elastic_beanstalk_application.auther-elastic-beanstalk-app]
# #   application = aws_elastic_beanstalk_application.auther-elastic-beanstalk-app.name
# #   bucket = aws_s3_bucket.auth_bucket.bucket
# #   key = "authrrrr-ebs-app.zip"
# #   name = "v1"
# # }


# #   # depends_on = ["aws_elastic_beanstalk_application.ebs-app"]
#   # application = "${aws_elastic_beanstalk_application.ebs-app.name}"
#   # bucket = "my.application.artefact"
#   # key = "deployables/my-sample-application.jar"
#   # name = "v1"


