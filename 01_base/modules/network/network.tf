# VPC
resource "aws_vpc" "vpc01" {
  cidr_block = var.vpc_cider
  tags = {
    Name = "${var.env}-vpc"
  }
}


# Subnet
## Public Subnet
### Public Subnet1
resource "aws_subnet" "public_subnet01" {
  vpc_id                  = aws_vpc.vpc01.id
  availability_zone       = var.az01
  cidr_block              = var.public_subnet01_cider
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-subnet-public1"
  }
}

### Public Subnet2
resource "aws_subnet" "public_subnet02" {
  vpc_id                  = aws_vpc.vpc01.id
  availability_zone       = var.az02
  cidr_block              = var.public_subnet02_cider
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-subnet-public2"
  }
}

## Private Subnet
### Private Subnet1
resource "aws_subnet" "private_subnet01" {
  vpc_id            = aws_vpc.vpc01.id
  availability_zone = var.az01
  cidr_block        = var.private_subnet01_cider
  tags = {
    "Name" = "${var.env}-subnet-private1"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc01.id
  tags = {
    Name = "${var.env}-igw"
  }
}

# NAT Gateway
## Elastic IP
resource "aws_eip" "eip_ngw01" {
  vpc = true
  tags = {
    Name = "${var.env}-eip-ngw01"
  }
}

## NAT Gateway
resource "aws_nat_gateway" "ngw01" {
  allocation_id = aws_eip.eip_ngw01.id
  subnet_id     = aws_subnet.public_subnet02.id
  tags = {
    Name = "${var.env}-ngw01"
  }
}



# Route Table
## RTB for Public Subnet
resource "aws_route_table" "public_rtb01" {
  vpc_id = aws_vpc.vpc01.id
  ### インターネット向きルーティング（IGW）
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "${var.env}-rtb-public1"
  }
}
### サブネットとRTBの紐づけ
resource "aws_route_table_association" "public_rtb01_association01" {
  subnet_id      = aws_subnet.public_subnet01.id
  route_table_id = aws_route_table.public_rtb01.id
}
resource "aws_route_table_association" "public_rtb01_association02" {
  subnet_id      = aws_subnet.public_subnet02.id
  route_table_id = aws_route_table.public_rtb01.id
}


## RTB for Private Subnet
resource "aws_route_table" "private_rtb01" {
  vpc_id = aws_vpc.vpc01.id
  ### インターネット向きルーティング（IGW）
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw01.id
  }

  tags = {
    Name = "${var.env}-rtb-private1"
  }
}

### サブネットとRTBの紐づけ
resource "aws_route_table_association" "private_rtb01_association01" {
  subnet_id      = aws_subnet.private_subnet01.id
  route_table_id = aws_route_table.private_rtb01.id
}

