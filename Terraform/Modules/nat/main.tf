resource "aws_nat_gateway" "nat" {
  subnet_id = var.public_subnet_id

    tags = {
      name = "nat-gateway"
    }
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_rt_association" {
    subnet_id = var.public_subnet_id
    route_table_id = aws_route_table.private_rt.id
  
}