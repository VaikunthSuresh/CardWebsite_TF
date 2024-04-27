#create a application load balancer

resource "aws_lb" "cardwebsite_alb" {
  name               = "cardwebsite-alb"
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = [var.subnet_ids[0], var.subnet_ids[1]]
}

#create a listener for ALB and target group

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.cardwebsite_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.tg_arns
  }
}