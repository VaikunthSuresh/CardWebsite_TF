resource "aws_autoscaling_group" "Custom_ASG" {
  name = "Custom ASG"
  vpc_zone_identifier = [var.subnet_ids[0],var.subnet_ids[1]]
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2
  target_group_arns = [var.tg_arns]
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
}

