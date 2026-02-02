
module "vpc" {
  source = "../../modules/vpc"

  vpc_name = "study-vpc"
  vpc_cidr = "10.0.0.0/16"
}
