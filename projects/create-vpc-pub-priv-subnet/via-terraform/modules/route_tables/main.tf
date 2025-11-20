# public route table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = { Name = "${var.name}-public-rt" }
}

resource "aws_route" "public_default" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = var.igw_id
}

resource "aws_route_table_association" "public_assoc" {
  for_each = var.public_subnets_map
  subnet_id = each.value
  route_table_id = aws_route_table.public.id
}

# private route tables, one per private subnet, routed to nat in same index
resource "aws_route_table" "private" {
  for_each = var.private_subnets_map
  vpc_id = var.vpc_id
  tags = { Name = "${var.name}-private-rt-${each.key}" }
}

resource "aws_route" "private_nat" {
  for_each = var.private_subnets_map
  route_table_id = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = var.nat_gateway_map[each.key]
}

resource "aws_route_table_association" "private_assoc" {
  for_each = var.private_subnets_map
  subnet_id = each.value
  route_table_id = aws_route_table.private[each.key].id
}
