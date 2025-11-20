# create public subnets
resource "aws_subnet" "public" {
  for_each = { for idx, cid in var.public_subnets : idx => cid }
  vpc_id = var.vpc_id
  cidr_block = each.value
  availability_zone = var.azs[tonumber(each.key)]
  map_public_ip_on_launch = true
  tags = { Name = "${var.name}-public-${each.key}" }
}

# create private subnets
resource "aws_subnet" "private" {
  for_each = { for idx, cid in var.private_subnets : idx => cid }
  vpc_id = var.vpc_id
  cidr_block = each.value
  availability_zone = var.azs[tonumber(each.key)]
  map_public_ip_on_launch = false
  tags = { Name = "${var.name}-private-${each.key}" }
}
