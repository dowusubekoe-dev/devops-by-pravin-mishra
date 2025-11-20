resource "aws_eip" "nat" {
  for_each = var.public_subnets_map

  tags = {
    Name = "${var.name}-nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "this" {
  for_each = var.public_subnets_map

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value

  tags = {
    Name = "${var.name}-nat-gw-${each.key}"
  }

  # ensures IGW/module ordering when passed in from the root module
  depends_on = [var.igw_dep]
}
