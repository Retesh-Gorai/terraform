# module "cloud_sql_instance1" {
#   source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
#   version = "~> 20.0"

#   project_id  = var.project_id
#   instance_id = var.instance_id
#   region      = var.region
#   database    = var.database
#   db_user     = var.db_user
#   db_password = var.db_password

#   # Database flags
#   database_flags = var.database_flags

#   # Machine type
#   machine_type = var.machine_type

#   # Storage
#   storage_size_gb = var.storage_size_gb

#   # Network
#   network      = var.network
#   subnetwork    = var.subnetwork
#   authorized_networks = var.authorized_networks

#   # SSL
#   require_ssl = var.require_ssl

#   # Backups
#   backup_enabled = var.backup_enabled
#   backup_retention_period = var.backup_retention_period

#   # Encryption
#   encryption_key_name = var.encryption_key_name

#   # Private service access
#   private_network = var.private_network
#   private_ip      = var.private_ip

#   # Other settings
#   deletion_protection = var.deletion_protection
# }
