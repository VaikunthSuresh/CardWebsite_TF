#create a launch template for ASG
#create a key pair

resource "aws_key_pair" "aws_key" {
  key_name = "publickey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDzGxCQx3WsPmE+XjdKFWjjzK68g7PafKotJzYVeviTAQhg+kKqGZ7O2ErMsTliPqsAf6RtI6xF0W0aOuIm7zC5LcdTAOrswG5Cz3JDxFI6sXrieJJHbwsHysyAZpgjaPH6YA09svDLZ9A7XVfJrZk3h+SmNT4QKRFuufGAlRiw9fcHJCCFYSnm0Urkpo3L8a1LXKjkWIZnK+w7LJuHoSI//zBGs50y/a1vaQ2H9xBHsATJkidremJWTbOMYGWO4sIVXBrBExMLLKrEvvjL3id90ewWA7t2L4Tx3aqGrZphR2AaAqqhv0eaZy+r1WA6K6SMLnKK9fcF7CkymWH371s9EOGKCCn2nV1z4xs1UTO1C1FRE7bn4d5OOSIFHtVH7tD/bFrL+9BlR0pMq8L75X/4N7dyBWKz+r+C+QdtRjMuAP6llkGHbBqlfLUzs9Z2HOm4+7QqJPb9CdzWCW9BcDznXOwaddBrSxc9ZuJlTF5FC6DH6URMxuTYC9WpEXF1/4s= vaiku@DESKTOP-6GKE77F"
  
}
resource "aws_launch_template" "my_launch_template" {
  name = "my-launch-template"
  image_id = var.ami_id

  instance_type = var.instance_type

  key_name = aws_key_pair.aws_key.id
  vpc_security_group_ids = [var.security_group_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "CustomInstance"
    }
  }

  user_data = filebase64(var.user_file)
}
