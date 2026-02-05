
variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "eks_node_sg_id" {}

variable "db_username" {
  description = "Master username for the RDS PostgreSQL instance"
  type        = string
}

variable "db_password" {
  description = "Master password for the RDS PostgreSQL instance"
  type        = string
  sensitive   = true
}
