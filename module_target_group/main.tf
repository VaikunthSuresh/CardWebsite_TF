#create target groups for ALB and attach it with instance

resource "aws_lb_target_group" "alb_target_group" {
  name = "alb-target-group"
  vpc_id = var.vpc_id
  port = 80
  protocol = "HTTP"
}
