# data "vault_generic_secret" "db_password" {
#   path = "secret/data/db"
# }


module "rds_mysql" {
source  = "../modules/rds-mysql"
name    = var.name
username = var.username
#password = data.vault_generic_secret.db_password.data.password
 password = var.password
 subnet_ids = data.aws_subnet_ids.all.ids
allocated_storage    = var.allocated_storage
primary_availability_zone = var.primary_availability_zone
secondary_availability_zone = var.secondary_availability_zone
region = var.region
#availability_zone = ${var.primary_availability_zone} ${ var.secondary_availability_zone}
#replica_count = length(var.secondary_availability_zone)
#availability_zone = concat([var.primary_availability_zone], var.secondary_availability_zone)
availability_zone = var.primary_availability_zone
}



data "aws_subnet_ids" "all" {
  vpc_id = var.vpc_id
}
