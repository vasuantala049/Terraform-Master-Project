output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_private_ip" {
  value = tolist(module.compute.private_ip)
}

output "db_endpoint" {
  value = module.database.db_endpoint
}

output "s3_bucket_name" {
  value = module.storage.bucket_name
}
