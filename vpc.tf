resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_tag_name
  }
}
resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.subnet_az
  tags = {
    Name = var.subnet_tag_name
  }
}
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "My VPC - Internet Gateway"
  }
}
resource "aws_route_table" "this" {
    vpc_id = aws_vpc.this.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }
    tags = {
        Name = "Public Subnet Route Table."
    }
}
resource "aws_route_table_association" "this" {
    subnet_id = aws_subnet.this.id
    route_table_id = aws_route_table.this.id
}