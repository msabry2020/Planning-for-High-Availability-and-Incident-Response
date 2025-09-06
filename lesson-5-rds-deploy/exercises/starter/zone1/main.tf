 module "vpc" {
   source     = "./modules/vpc"
   cidr_block = "10.100.0.0/16"
   name          = "udacity-rds"
   azs           = ["us-east-2a","us-east-2b"]
 }
