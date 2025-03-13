resource "aws_vpc" "main" {
        cidr_block      = var.vpc_cidr
        enable_dns_support = true
    tags = {
        Name = "mainVPC"
        Owner = "guytamari"
    }
}

resource "aws_subnet" "public" {
        vpc_id  = aws_vpc.main.id
        availability_zone = var.availability_zone
        cidr_block = var.public_subnet_cidr
        map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet"
        Owner = "guytamari"
    }

}

resource "aws_subnet" "private" {
        vpc_id  = aws_vpc.main.id
        availability_zone = var.availability_zone
        cidr_block = var.private_subnet_cidr
    tags = {
        Name = "private-subnet"
        Owner = "guytamari"
    }

}

# IGW
resource "aws_internet_gateway" "main" {
        vpc_id = aws_vpc.main.id
  tags = {
        Name = "mainGW"
        Owner = "guytamari"
  }
}

# elastic ip for the nat
resource "aws_eip" "nat" {
        domain = "vpc"
}

# attaching nat gw to the public subnet
resource "aws_nat_gateway" "main" {
        allocation_id = aws_eip.nat.id
        subnet_id     = aws_subnet.public.id
  tags = {
        Name = "mainNAT"
        Owner = "guytamari"
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
        Owner = "guytamari"
  }
}


# modifing the route table for the private subnet
resource "aws_route_table" "private" {
        vpc_id = aws_vpc.main.id
        route {
            cidr_block     = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.main.id
        }
        tags = {
            Name = "PrivateRouteTable"
        }
}

# attaching RT to the public subnet
resource "aws_route_table_association" "public" {
        route_table_id = aws_route_table.public.id
        subnet_id      = aws_subnet.public.id
  
}

# attaching RT to the private subnet
resource "aws_route_table_association" "private" {
        subnet_id      = aws_subnet.private.id
        route_table_id = aws_route_table.private.id
}