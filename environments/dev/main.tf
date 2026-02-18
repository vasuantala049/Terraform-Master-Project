module "vpc"{
    source= "../../modules/vpc"
     environment = "dev"
     availability_zone_1 = var.availability_zone_1
     availability_zone_2 = var.availability_zone_2
}
module "security" {
  source = "../../modules/security"
  environment = var.environment
  vpc_id = module.vpc.vpc_id
  db_port = 3306
  app_port = 8080
  enable_kms = true
  enable_cloudtrail = true
  enable_guardduty = false
  allowed_cidr_blocks = var.allowed_cidr_blocks
}

module "compute" {
  source = "../../modules/compute"
  environment = var.environment
  instance_count = var.instance_count
  ami_id = var.ami_id
  instance_type = var.instance_type
  subnet_ids = module.vpc.private_subnet_ids

  app_sg_id = module.security.app_sg_id
  instance_profile_name = module.security.ec2_instance_profile_name

}
module "database" {
    source = "../../modules/database"
    environment = var.environment
     allocated_storage = var.allocated_storage
     engine = var.db_type
     engine_version = var.db_version
     db_username = module.security.db_username
     db_password = module.security.db_password
     db_instance_class = var.db_instance_class
     private_subnet_ids = module.vpc.private_subnet_ids
     db_sg_id = module.security.db_sg_id
     kms_key_id = module.security.kms_key_arn
     db_secret_arn = module.security.db_secret_arn
  
}
module "storage" {
  source = "../../modules/storage"
    environment = var.environment
        kms_key_id = module.security.kms_key_id

}