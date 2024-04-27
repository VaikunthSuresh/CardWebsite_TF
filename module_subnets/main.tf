#create 2 private subnets
resource "aws_subnet" "private_subnets" {
  
  vpc_id = var.vpc_id
  count = length(var.private_cidr_blocks)
  cidr_block = element(var.private_cidr_blocks,count.index)
  availability_zone = element(var.availability_zones,count.index)
  tags = {
    Name = "private_subnet ${count.index+1}" 
  }
}

#create 2 public subnets
resource "aws_subnet" "public_subnets" {
  
  vpc_id = var.vpc_id
  count = length(var.public_cidr_blocks)
  cidr_block = element(var.public_cidr_blocks,count.index)
  map_public_ip_on_launch = true
  availability_zone = element(var.availability_zones,count.index)

  tags = {
    Name = "public_subnet ${count.index+1}" 
  }
}
