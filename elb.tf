resource "aws_lb" "net" {
  name               = "${local.name}"
  subnets            = ["${aws_subnet.net_public[0].id}", "${aws_subnet.net_private[1].id}"]
  security_groups    = [aws_security_group.net_sg.id]
  internal           = false
  load_balancer_type = "application"
  enable_http2       = true
  idle_timeout       = 30
  tags               = local.tags
}

resource "aws_lb_target_group" "blue" {
  name        = "${local.name}-blue"
  port        = 8080
  target_type = "ip"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.net.id
  depends_on  = [aws_lb.net]
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    port                = 8080
    interval            = 10
    timeout             = 5
    unhealthy_threshold = 3
    healthy_threshold   = 3
  }
}

resource "aws_lb_target_group" "green" {
  name        = "${local.name}-green"
  port        = 80
  target_type = "ip"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.net.id
  depends_on  = [aws_lb.net]
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = 8080
    matcher             = "200"
    interval            = 10
    timeout             = 5
    unhealthy_threshold = 3
    healthy_threshold   = 3
  }
}

resource "aws_lb_listener" "green" {
  load_balancer_arn = aws_lb.net.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }
  depends_on = [aws_lb_target_group.green]
}

resource "aws_lb_listener" "blue" {
  load_balancer_arn = aws_lb.net.arn
  port              = "8080"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
  depends_on = [aws_lb_target_group.blue]
}
