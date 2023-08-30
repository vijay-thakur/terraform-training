resource "aws_security_group" "rds_db_sg" {
  name        = "tutorial_db_sg"
  description = "Security group for Mysql database"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow MySQL traffic from VPC cidr block"
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-vpc"
  })
}

resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name        = "rds_db_subnet_group"
  description = "DB subnet group for tutorial"
  subnet_ids  = [var.private_subnet_id_1, var.private_subnet_id_2]
}

# initial password
resource "random_password" "db_master_pass" {
  length           = 15
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"
}

# the secret
resource "aws_secretsmanager_secret" "db-pass" {
  name = "rds-db-password"
}

# initial version
resource "aws_secretsmanager_secret_version" "db-pass-val" {
  secret_id = aws_secretsmanager_secret.db-pass.id
  secret_string = jsonencode(
    {
      username = aws_db_instance.mysql-rds.username
      password = aws_db_instance.mysql-rds.password
      engine   = "mysql"
      host     = aws_db_instance.mysql-rds.endpoint
    }
  )
}

resource "aws_db_instance" "mysql-rds" {
  identifier              = "${var.global_tag_prefix}-mysql-rds"
  allocated_storage       = var.allocated_storage
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  db_subnet_group_name    = aws_db_subnet_group.rds_db_subnet_group.name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  multi_az                = var.multi_az
  db_name                 = var.dbname
  username                = var.dbusername
  password                = random_password.db_master_pass.result
  port                    = var.port
  publicly_accessible     = var.publicly_accessible
  storage_encrypted       = var.storage_encrypted
  storage_type            = var.storage_type

  vpc_security_group_ids = [aws_security_group.rds_db_sg.id]

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade

  final_snapshot_identifier = var.final_snapshot_identifier
  snapshot_identifier       = var.snapshot_identifier
  skip_final_snapshot       = var.skip_final_snapshot

  performance_insights_enabled = var.performance_insights_enabled
  tags                         = merge(var.global_tags)
}
