variable "public_subnets_map" {
  type = map(string)
  # expected: { "az1" = subnet-123, "az2" = subnet-456 }
}

variable "name" {
  type    = string
  default = "demo"
}

variable "igw_dep" {
  type    = any
  default = []
}
