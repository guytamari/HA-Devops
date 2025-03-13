# creation of the vpc itself
resource "aws_vpc" "main" {
        cidr_block      = var.vpc_cidr
        enable_dns_support = true
    tags = {
        Name = "mainVPC"
        Owner = var.owner
    }
}
# creation public subnet in az1
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zones[0]  # using first az
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name  = "public-subnet-az1"
    Owner = var.owner
  }
}
# creation public subnet in az2
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zones[1]  # using second az
  cidr_block              = var.public_subnet_cidr_az2
  map_public_ip_on_launch = true
  tags = {
    Name  = "public-subnet-az2"
    Owner = var.owner
  }
}
# creation private subnet in  az1
resource "aws_subnet" "private" {
        vpc_id  = aws_vpc.main.id
        availability_zone = var.availability_zones[0]
        cidr_block = var.private_subnet_cidr
    tags = {
        Name = "private-subnet"
        Owner = var.owner
    }

}

# IGW
resource "aws_internet_gateway" "main" {
        vpc_id = aws_vpc.main.id
  tags = {
        Name = "mainGW"
        Owner = var.owner
  }
}

# elastic ip for the nat in az1
resource "aws_eip" "nat_az1" {
        domain = "vpc"
}
# elastic ip for the nat in az2
resource "aws_eip" "nat_az2" {
        domain = "vpc"
}

# attaching nat gw to the public subnet az1
resource "aws_nat_gateway" "nat_az1" {
        allocation_id = aws_eip.nat_az1.id
        subnet_id     = aws_subnet.public_az1.id
        tags = {
            Name  = "nat-az1"
            Owner = var.owner
        }
}

# attaching nat gw to the public subnet az2
resource "aws_nat_gateway" "nat_az2" {
  allocation_id = aws_eip.nat_az2.id
  subnet_id     = aws_subnet.public_az2.id
  tags = {
    Name  = "nat-az2"
    Owner = var.owner
  }
}

# modifing the route table for the public subnet
resource "aws_route_table" "public" {
        vpc_id = aws_vpc.main.id
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.main.id
  }

  tags = {
        Name = "publicRT"
        Owner = var.owner
  }
}


# modifing the route table for the private subnet
resource "aws_route_table" "private" {
        vpc_id = aws_vpc.main.id
        route {
            cidr_block     = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.nat_az1.id
        }
        tags = {
            Name = "PrivateRouteTable"
        }
}

# attaching RT to the public subnet az1
resource "aws_route_table_association" "public_az1" {
        route_table_id = aws_route_table.public.id
        subnet_id      = aws_subnet.public_az1.id
  
}

# attaching RT to the public subnet az2
resource "aws_route_table_association" "public_az2" {
        route_table_id = aws_route_table.public.id
        subnet_id      = aws_subnet.public_az2.id
}

# attaching RT to the private subnet
resource "aws_route_table_association" "private" {
        subnet_id      = aws_subnet.private.id
        route_table_id = aws_route_table.private.id
}