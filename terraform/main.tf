module "vpc" {
  source = "./modules/vpc"
  region = "us-east-1"
}

module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = [module.vpc.private_subnet_id_a, module.vpc.private_subnet_id_b]
  db_name            = "mydb"
  db_username        = "postgres"
  db_password        = var.db_password
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "kosaeszter-cvproject-devops-app"
  tags            = {
    Name = "kosaeszter-ecr-repo"
  }
}