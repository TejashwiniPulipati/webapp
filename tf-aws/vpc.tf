# VPC
resource "aws_vpc" "lms-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lms-vpc"
  }
}

# web-subnet
resource "aws_subnet" "lms-web-sn" {
  vpc_id     = aws_vpc.lms-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "lms-web-subnet"
  }
}

# api-subnet
resource "aws_subnet" "lms-api-sn" {
  vpc_id     = aws_vpc.lms-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "lms-api-subnet"
  }
}

# db-subnet
resource "aws_subnet" "lms-db-sn" {
  vpc_id     = aws_vpc.lms-vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "lms-db-subnet"
  }
}

# internet-gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lms-vpc.id

  tags = {
    Name = "lms-igw"
  }
}

# public-route-table
resource "aws_route_table" "lms-pub-rt" {
  vpc_id = aws_vpc.lms-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "lms-public-rt"
  }
}

# web-subnet-association
resource "aws_route_table_association" "web-sn-asc" {
  subnet_id      = aws_subnet.lms-web-sn.id
  route_table_id = aws_route_table.lms-pub-rt.id
}

# api-subnet-association
resource "aws_route_table_association" "api-sn-asc" {
  subnet_id      = aws_subnet.lms-api-sn.id
  route_table_id = aws_route_table.lms-pub-rt.id
}

