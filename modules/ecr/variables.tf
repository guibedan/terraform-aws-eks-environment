
variable "repositories" {
  description = "Mapa de repositórios ECR"
  type = map(object({
    scan_on_push = bool
  }))
}

variable "tags" {
  description = "Tags padrão"
  type        = map(string)
  default     = {}
}
