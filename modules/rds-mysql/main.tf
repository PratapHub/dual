resource "aws_rds_cluster_parameter_group" "cluster" {
  name_prefix = var.name
  family      = "aurora-mysql5.7"
  description = "A custom parameter group for Aurora MySQL 5.7"
  parameter   {
    name  = "character_set_server"
    value = "utf8"
  }
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier           = var.name
  engine                       = "aurora-mysql"
  engine_version               = "5.7.mysql_aurora.2.07.2"
  database_name                = "mydb"
  master_username              = var.username
  master_password              = var.password
  backup_retention_period      = 7
  preferred_backup_window      = "07:00-09:00"
  db_subnet_group_name         = aws_db_subnet_group.mysql.name
  vpc_security_group_ids       = [aws_security_group.mysql.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster.name
}

resource "aws_rds_cluster_instance" "primary" {
  count                        = 1
  identifier                   = "${var.name}-primary"
  engine                       = "aurora-mysql"
  instance_class               = "db.t2.medium"
  db_subnet_group_name         = aws_db_subnet_group.mysql.name
  db_parameter_group_name      = aws_db_parameter_group.mysql.name
  availability_zone            = var.primary_availability_zone
  cluster_identifier           = aws_rds_cluster.cluster.id
}

resource "aws_rds_cluster_instance" "secondary" {
  count                        = length(var.secondary_availability_zone)
  identifier                   = "${var.name}-secondary-${count.index + 1}"
  engine                       = "aurora-mysql"
  instance_class               = "db.t2.medium"
  db_subnet_group_name         = aws_db_subnet_group.mysql.name
  db_parameter_group_name      = aws_db_parameter_group.mysql.name
  availability_zone            = element(var.secondary_availability_zone, count.index)
  cluster_identifier           = aws_rds_cluster.cluster.id
}

resource "aws_rds_global_cluster" "global_cluster" {
  engine_mode                  = "multiregion-active"
  global_cluster_identifier    = "${var.name}-global"
  source_db_cluster_identifier = aws_rds_cluster.cluster.id
  region                       = var.secondary_region
}

resource "aws_security_group" "mysql" {
  name_prefix = "mysql"
}

resource "aws_db_subnet_group" "mysql" {
  name        = "mysql"
  subnet_ids  = var.subnet_ids
}

resource "aws_db_parameter_group" "mysql" {
  name = "mysql"
  family = "aurora-mysql5.7"
  parameter {
    name  = "max_connections"
    value = "100"
  }
}
