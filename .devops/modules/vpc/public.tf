#### Public Subnets

# Public Subnet A
resource "aws_subnet" "public_subnet_A" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_A

  tags = {
    Name = "${var.cluster_name}-public-subnet-A"
  }
}

# Public Subnet B
resource "aws_subnet" "public_subnet_B" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_B

  tags = {
    Name = "${var.cluster_name}-public-subnet-B"
  }
}

# Associate subnet public_subnet_A to public route table
resource "aws_route_table_association" "public_subnet_A_association" {
  subnet_id      = aws_subnet.public_subnet_A.id
  route_table_id = aws_vpc.cluster_vpc.main_route_table_id
}

# Associate subnet public_subnet_B to public route table
resource "aws_route_table_association" "public_subnet_B_association" {
  subnet_id      = aws_subnet.public_subnet_B.id
  route_table_id = aws_vpc.cluster_vpc.main_route_table_id
}
