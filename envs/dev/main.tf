
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

module "ecr" {
  source = "../../modules/ecr"

  repositories = {
    "orders-service" = {
      scan_on_push = true
    }
    "payments-service" = {
      scan_on_push = true
    }
  }

  tags = {
    Environment = "dev"
    Project     = "eks-study"
  }
}

module "eks_iam" {
  source = "../../modules/iam/eks"

  cluster_name = "eks-study"

  tags = {
    Environment = "dev"
    Project     = "eks-study"
  }
}
