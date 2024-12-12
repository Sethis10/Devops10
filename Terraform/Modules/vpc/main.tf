resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

    tags = {
      name = "${var.project_name}-vpc"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

    tags = {
      name = "${var.project_name}-igw"
    }
}

data "aws_availability_zones" "availability_zone" {
    state = "available"
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.availability_zone[0]

    tags = {
        name = "${var.project_name}-public-subnet"
    }      
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

    tags = {
      name = "public-rt"
    }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = data.aws_avaibility_zones.availability_zone[1]

    tags = {
      name = "${var.project_name}-private-subnet"
    }
}