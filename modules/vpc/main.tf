resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = local.resource_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = local.resource_name
  }
}

# Both subnets use the main route table, so this one route makes them public.
resource "aws_route" "internet" {
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_1_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.resource_name}-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_2_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.resource_name}-2"
  }
}

# RDS needs subnets in at least two availability zones.
resource "aws_db_subnet_group" "this" {
  name       = local.resource_name
  subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  tags = {
    Name = local.resource_name
  }
}

resource "aws_security_group" "ec2" {
  name        = "${local.resource_name}-ec2"
  description = "Access to the EC2 instance"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${local.resource_name}-ec2"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2" {
  for_each = local.ec2_ingress

  security_group_id = aws_security_group.ec2.id
  description       = "TCP ${each.value.port} from ${each.value.cidr}"
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.port
  to_port           = each.value.port
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ec2" {
  security_group_id = aws_security_group.ec2.id
  description       = "All outbound traffic, for example package downloads"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "postgres" {
  name        = "${local.resource_name}-postgres"
  description = "Access to the PostgreSQL instance"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${local.resource_name}-postgres"
  }
}

# Only the EC2 security group may connect. The database has no outbound rules.
resource "aws_vpc_security_group_ingress_rule" "postgres" {
  security_group_id            = aws_security_group.postgres.id
  description                  = "PostgreSQL from the EC2 security group"
  referenced_security_group_id = aws_security_group.ec2.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}
