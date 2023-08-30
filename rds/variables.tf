variable "global_tags" {
  description = "Global tags to be passed to resources in submodule"
  type        = map(string)
  default     = {}
}

variable "private_subnet_id_1" {
  description = "ID of the private subnet 1"
}

variable "private_subnet_id_2" {
  description = "ID of the private subnet 2"
}

variable "global_tag_prefix" {
  description = "Global tag prefix"
  default     = "vijay"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
}

variable "allocated_storage" {
  description = "Mysql RDS DB storage in GB"
  default     = 20
}

variable "backup_retention_period" {
  description = "Mysql RDS DB backup_retention_period in days"
  default     = 1
}

variable "backup_window" {
  description = "Mysql RDS Backup window time period"
  default     = "10:46-11:16"
}

variable "maintenance_window" {
  description = "Mysql RDS maintenance window time period"
  default     = "Sun:00:00-Sun:03:00"

}

variable "engine" {
  description = "Database Type like mysql, oracle"
  default     = "mysql"
}

variable "engine_version" {
  description = "Database Engine Version"
  default     = "8.0.33"
}

variable "instance_class" {
  description = "Mysql RDS instance tier"
  default     = "db.t3.small"
}

variable "multi_az" {
  description = "Mysql RDS enable multi AZ or not"
  default     = false
}

variable "dbname" {
  description = "Mysql RDS Database Name"
  default     = "vijay"
}

variable "dbusername" {
  description = "Mysql RDS Database User Name"
  default     = "admin"
}

variable "port" {
  description = "Mysql RDS Port"
  default     = "3306"
}

variable "publicly_accessible" {
  description = "Mysql RDS allow publicly accessible or not"
  default     = false
}

variable "storage_encrypted" {
  description = "Mysql RDS storage encrypt or not"
  default     = true
}

variable "storage_type" {
  description = "Mysql RDS Storage tpye like gp2 or gp3"
  default     = "gp3"
}

variable "allow_major_version_upgrade" {
  description = "Allow major version upgrade"
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Allow minor version upgrade"
  default     = true
}

variable "final_snapshot_identifier" {
  description = "name of the final snapshot after deletion"
  default     = "final-vijay-snaphot"
}

variable "snapshot_identifier" {
  description = "used to recover from a snapshot"
  default     = null
}

variable "skip_final_snapshot" {
  description = "Skip final Sanpshot before deletion"
  default     = true
}

variable "performance_insights_enabled" {
  description = "Enable performance insights or not"
  default     = false
}