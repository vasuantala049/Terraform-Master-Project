resource "aws_vpc" "main_vpc" {

  cidr_block = var.vpc_cidr_block
  tags = {
    Name = local.vpc_name
    Environment = var.environment
  }
}
resource "aws_subnet" "public_subnet_1" {

  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_1_cidr_block
  availability_zone = var.availability_zone_1
  map_public_ip_on_launch = true
  tags = {
    Name = local.public_subnet_1_name
    Environment = var.environment
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_2_cidr_block
  availability_zone = var.availability_zone_2
    map_public_ip_on_launch = true
    
  tags = {
    Name = local.public_subnet_2_name
    Environment = var.environment
  }
}
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_1_cidr_block
  availability_zone = var.availability_zone_1
  map_public_ip_on_launch = false
  tags = {
    Name = local.private_subnet_1_name
    Environment = var.environment
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_2_cidr_block
  availability_zone = var.availability_zone_2
    map_public_ip_on_launch = false
  tags = {
    Name = local.private_subnet_2_name
    Environment = var.environment
  }
}
resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = local.internet_gateway_name
    Environment = var.environment
  }
}
resource "aws_eip" "elastic_ip" {
    domain = "vpc"
    tags = {
        Name = "${var.environment}-nat-gateway-eip"
        Environment = var.environment
    }
}
resource "aws_nat_gateway" "main_nat_gateway" {
    allocation_id = aws_eip.elastic_ip.id
    subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = local.nat_gateway_name
    Environment = var.environment
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_internet_gateway.id
  }
  tags = {
    Name = local.public_route_table_name
    Environment = var.environment
  }
}
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat_gateway.id
  }
    tags = {
        Name = local.private_route_table_name
        Environment = var.environment
    }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
  
}
resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}
