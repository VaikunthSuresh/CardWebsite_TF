output "subnets_id_private" {
  value = [aws_subnet.private_subnets[0].id,aws_subnet.private_subnets[1].id]
}

output "subnets_id_public" {
  value = [aws_subnet.public_subnets[0].id,aws_subnet.public_subnets[1].id]
}