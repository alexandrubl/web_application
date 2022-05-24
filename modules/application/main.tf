resource "aws_lb" "alb" {
    name = "alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [var.alb_sg_id]
    subnets            = var.public_subnets
}

resource "aws_alb_target_group" "alb_tg" {
    name         = "albtg"
    protocol     = "HTTP"
    port         = "80"
    vpc_id       = var.vpc_id
    health_check {
        path     = "/"
        interval            = 10
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 2
        protocol = "HTTP"
    } 
}

resource "aws_alb_target_group" "app_tg" {
    name         = "apptg"
    protocol     = "HTTP"
    port         = "8080"
    vpc_id       = var.vpc_id
    health_check {
        path     = "/ok"
        interval            = 10
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 2
        protocol = "HTTP"
    } 
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn  = aws_lb.alb.arn
  port               = "80"
  protocol           = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_tg.arn
  }
}

resource "aws_alb_listener_rule" "alb_rule" {
    listener_arn = aws_alb_listener.alb_listener.arn

    action {
        type = "forward"
        target_group_arn = aws_alb_target_group.alb_tg.arn
    }
    condition {
        path_pattern {
            values = ["/"]
        }
    }
}

resource "aws_alb_listener_rule" "app_rule" {
    listener_arn = aws_alb_listener.alb_listener.arn

    action {
        type = "forward"
        target_group_arn = aws_alb_target_group.app_tg.arn
    }
    condition {
        path_pattern {
            values = [
                "/languages",
                "/languages/*",
                "/languages/*/*",
                "/ok"]
        }
    }
}

#resource "aws_autoscaling_group" "MyASG" {
#  vpc_zone_identifier = var.private_subnets
#  desired_capacity = 2
#  max_size         = 3
#  min_size         = 1
  
#  target_group_arns = [aws_alb_target_group.alb_tg.arn, aws_alb_target_group.app_tg.arn]

#  launch_template {
#      id = aws_launch_template.webserver.id
#      version = "$Latest"
# }
#}

#data "aws_instances" "webserver" {
#  instance_tags = {
#    Name  = "Webserver"
#  }

#  instance_state_names = ["pending", "running"]

#  depends_on = [
#    aws_autoscaling_group.MyASG
#  ]
#}