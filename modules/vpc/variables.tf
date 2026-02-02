
variable "vpc_cidr" {
  description = "CIDR block da VPC"
  type        = string
}

variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
}

variable "availability_zones" {
  description = "Lista de AZs"
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "CIDRs das subnets públicas"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "CIDRs das subnets privadas"
  type        = list(string)
}
