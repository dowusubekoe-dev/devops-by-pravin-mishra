output "public_route_table_id" { value = aws_route_table.public.id }
output "private_route_table_ids" { value = { for k, rt in aws_route_table.private : k => rt.id } }
