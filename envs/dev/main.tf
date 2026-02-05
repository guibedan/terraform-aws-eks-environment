
module "vpc" {
  source = "../../modules/vpc"

  vpc_name = "study-vpc"
  vpc_cidr = "10.0.0.0/16"

  availability_zones = ["us-east-1a", "us-east-1b"]

  public_subnets_cidr = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets_cidr = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  project_name = "study-eks"
}
