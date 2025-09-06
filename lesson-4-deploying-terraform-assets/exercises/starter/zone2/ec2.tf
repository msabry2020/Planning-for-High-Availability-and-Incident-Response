  module "project_ec2" {
   source             = "./modules/ec2" 
   instance_count     = 2
   name               = "Ubuntu-Web"
   account            = data.aws_caller_identity.current.account_id
   aws_ami            = "ami-0945610b37068d87a"
   private_subnet_ids = module.vpc.private_subnet_ids
   public_subnet_ids  = module.vpc.private_subnet_ids 
   vpc_id             = module.vpc.vpc_id
   tags = {
      Name = "Ubuntu-Web"
   }
 }
