# VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr 
    instance_tenancy = "default"

    tags ={
      "Name" = "my-vpc"  
    }
}

# Subnets

resource "aws_subnet" "subnets" {
  count =  length(var.subnet_cidr)  # length(var.subnet_cidr) = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true  #optional field , gives a public ip address to instance when launched inside subnet 
  tags = {
      Name = var.subnet_names[count.index]
  }
}

# Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyIternetGateway"
  }
}

# Route Table

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0" #public
    gateway_id = aws_internet_gateway.igw.id
  }


}

# Route Table Association
resource "aws_route_table_association" "rta" {
  count = length(var.subnet_cidr)  
  subnet_id = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rt.id
}