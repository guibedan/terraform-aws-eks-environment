
variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "tags" {
  description = "Tags padrão"
  type        = map(string)
  default     = {}
}
