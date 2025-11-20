variable "vpc_id" { 
    type = string 
    }

variable "igw_id" { 
    type = string 
    }

variable "public_subnets_map" { 
    type = map(string) 
    }

variable "private_subnets_map" { 
    type = map(string) 
    }

variable "nat_gateway_map" { 
    type = map(string) 
    }
     # key -> nat id
variable "name" { 
    type = string 
    default = "demo" 
    }