
resource "aws_ecr_repository" "this" {
  for_each = var.repositories

  name = each.key

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }

  tags = var.tags
}
