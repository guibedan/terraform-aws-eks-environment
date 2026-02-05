
terraform {
  backend "s3" {
    bucket         = "guibedan-terraform-state-eks-study"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-eks-study"
    encrypt        = true
  }
}
