
variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "cluster_role_arn" {
  description = "ARN da role do cluster EKS"
  type        = string
}

variable "tags" {
  description = "Tags do cluster"
  type        = map(string)
  default     = {}
}

variable "node_instance_type" {
  description = "Tipo de instância dos nodes"
  type        = string
  default     = "t3.micro"
}

variable "node_desired_size" {
  description = "Quantidade desejada de nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Máximo de nodes"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Mínimo de nodes"
  type        = number
  default     = 1
}

variable "node_role_arn" {
  description = "ARN da role dos nodes"
  type        = string
}

variable "private_subnet_ids" {
  description = "Lista de subnets privadas para o EKS"
  type        = list(string)
}
