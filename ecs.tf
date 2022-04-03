resource "aws_ecs_cluster" "net_cluster" {
  name = "net_cluster"
  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.kms_key.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.net_log_group.name
      }
    }
  }
}


resource "aws_ecs_task_definition" "net_task_def" {
  family                   = "net_task_def"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_excecution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_service_role.arn

  container_definitions = jsonencode([
    {
      name : local.name,
      image : "${aws_ecr_repository.net.arn}:latest",
      cpu : 1024,
      memory : 2048,
      essential : true,
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : "${aws_cloudwatch_log_group.net_log_group.name}",
          "awslogs-region" : "${local.aws_region}",
          "awslogs-stream-prefix" : "ecs",
        }
      },
      portMappings : [
        {
          containerPort : 3000,
          hostPort : 3000,
          protocol : "tcp"
        }
      ],
      #   environment : [
      #     {
      #       name : "PORT",
      #       value : 3000
      #     },
      #   ]

    }
  ])
}


resource "aws_ecs_service" "api" {
  name            = local.name
  cluster         = aws_ecs_cluster.net_cluster.id
  task_definition = aws_ecs_task_definition.net_task_def.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  depends_on      = [aws_lb_listener.green, aws_lb_listener.blue]

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.green.arn
    container_name   = local.name
    container_port   = 3000
  }

  network_configuration {
    subnets          = [aws_subnet.net_private[0].id, aws_subnet.net_private[1].id]
    security_groups  = [aws_security_group.net_sg.id]
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }
}
