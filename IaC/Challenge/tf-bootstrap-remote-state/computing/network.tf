resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
    Name = "tf-challenge-vpc"
    }
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = { Name = "tf-challenge-igw" }
}


resource "aws_subnet" "public" {
    for_each = { for idx, az in local.azs : az => idx }
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.public_subnet_cidrs[each.value]
    availability_zone = each.key
    map_public_ip_on_launch = true
    tags = {
    Name = "public-${each.key}"
    Tier = "Web"
    }
}


resource "aws_subnet" "private" {
    for_each = { for idx, az in local.azs : az => idx }
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.private_subnet_cidrs[each.value]
    availability_zone = each.key
    map_public_ip_on_launch = false
    tags = {
    Name = "private-${each.key}"
    Tier = "App"
    }
}


resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
    tags = { Name = "public-rt" }
}

resource "aws_route_table_association" "public_assoc" {
    for_each = aws_subnet.public
    subnet_id      = each.value.id
    route_table_id = aws_route_table.public.id
}
