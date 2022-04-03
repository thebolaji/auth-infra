resource "aws_vpc" "net" {
  cidr_block           = "10.0.0.0/20"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = local.tags
}

# ------- Subnets Creation -------



resource "aws_subnet" "net_public" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.net.id
  availability_zone       = var.azs[count.index]
  cidr_block              = var.subnets-pub[count.index]
  map_public_ip_on_launch = true
  tags                    = local.tags
}

resource "aws_subnet" "net_private" {
  vpc_id            = aws_vpc.net.id
  count             = length(var.azs)
  availability_zone = var.azs[count.index]
  cidr_block        = var.subnets-priv[count.index]
  tags              = local.tags
}


resource "aws_internet_gateway" "net_ig" {
  vpc_id = aws_vpc.net.id
  tags   = local.tags
}

resource "aws_eip" "net_elastic_ip" {
  vpc        = true
  depends_on = [aws_internet_gateway.net_ig]
  tags       = local.tags
}

resource "aws_nat_gateway" "net_nat" {
  allocation_id = aws_eip.net_elastic_ip.id
  subnet_id     = aws_subnet.net_public[0].id
  # depends_on    = [aws_internet_gateway.net_ig]
  tags = local.tags
}


resource "aws_route_table" "net_public" {
  vpc_id = aws_vpc.net.id
  tags   = local.tags
}

resource "aws_route" "net_route_public" {
  route_table_id         = aws_route_table.net_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.net_ig.id
}

resource "aws_route_table" "net_private" {
  vpc_id = aws_vpc.net.id
  tags   = local.tags
}

resource "aws_route" "net_route_private" {
  route_table_id         = aws_route_table.net_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.net_nat.id
}

resource "aws_route_table_association" "net_rtb_ass_public" {
  count          = 2
  subnet_id      = aws_subnet.net_public[count.index].id
  route_table_id = aws_route_table.net_public.id
}

resource "aws_route_table_association" "net_rtb_ass_private" {
  count          = 2
  subnet_id      = aws_subnet.net_private[count.index].id
  route_table_id = aws_route_table.net_private.id
}

resource "aws_security_group" "net_sg" {
  name       = "net_sg_demo"
  vpc_id     = aws_vpc.net.id
  depends_on = [aws_vpc.net]

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    self        = true
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    self        = true
  }

  tags = local.tags
}
