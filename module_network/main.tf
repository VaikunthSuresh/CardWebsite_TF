#create Internet Gateway

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = var.vpc_id
  
  tags = {
    Name= "My Internet Gateway"
  }
  
}

#create public route table

resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id

  }
  tags = {
    Name = "Public Route Table"
  }
  
}

#create private route table

resource "aws_route_table" "private_rt" {

  vpc_id = var.vpc_id

  tags = {
    Name = "Private Route Table"
  } 
  }


#Route table association for public subnets

resource "aws_route_table_association" "public_subnet_0_route_association" {
  
  route_table_id = aws_route_table.public_rt.id
  subnet_id = var.public_subnets[0]
}

resource "aws_route_table_association" "public_subnet_1_route_association" {
  
  route_table_id = aws_route_table.public_rt.id
  subnet_id = var.public_subnets[1]
}


#Route table association for private subnets

resource "aws_route_table_association" "private_subnet_0_route_association" {
  
  route_table_id = aws_route_table.private_rt.id
  subnet_id = var.private_subnets[0]
}

resource "aws_route_table_association" "private_subnet_1_route_association" {
  
  route_table_id = aws_route_table.private_rt.id
  subnet_id = var.private_subnets[1]
}
