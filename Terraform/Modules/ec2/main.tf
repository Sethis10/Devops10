resource "aws_instance" "db-server" {
  ami = var.ami
  key_name = var.key
  instance_type = "t2.micro"
  subnet_id = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.private-sg.id]
  associate_public_ip_address = false
}

resource "aws_instance" "web-server" {
  ami = var.ami
  key_name = var.key
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  associate_public_ip_address = true
}

resource "aws_security_group" "public-sg" {
name        = "public-sg"
description = "Security group for public EC2"
vpc_id      = var.vpc_id

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private-sg" {
name        = "private-sg"
description = "Security group for private EC2"
vpc_id      = var.vpc_id

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.public-sg.id]
  }
}



