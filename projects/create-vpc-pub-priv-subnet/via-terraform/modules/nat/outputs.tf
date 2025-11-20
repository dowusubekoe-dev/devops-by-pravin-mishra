output "nat_gateway_ids" {
  value = {
    for k, nat in aws_nat_gateway.this : k => nat.id
  }
}

output "eip_ids" {
  value = {
    for k, eip in aws_eip.nat : k => eip.id
  }
}
