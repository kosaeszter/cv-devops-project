# VPC
resource "aws_vpc" "main" {
 cidr_block = var.vpc_cidr
 enable_dns_hostnames = true
 tags = {
   Name = "kosaeszter-cvproject-devops-vpc"
 }
}

# Private Subnets
resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_a_cidr
  availability_zone = "${var.region}a"
  tags = {
   Name = "kosaeszter-private-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_b_cidr
  availability_zone = "${var.region}b"
  tags = {
    Name = "kosaeszter-private-subnet-b"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = "${var.region}a"
  tags = {
    Name = "kosaeszter-public-subnet-a"
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_b_cidr
  availability_zone = "${var.region}b"
  tags = {
    Name = "kosaeszter-public-subnet-b"
  }
  map_public_ip_on_launch = true
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "kosaeszter-my-devops-igw"
  }
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "kosaeszter-public-route-table"
  }
}

# Route Table Associations
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}