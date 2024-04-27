# create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr_block
  
  tags = {
    Name = "my-vpc"
  }
}
