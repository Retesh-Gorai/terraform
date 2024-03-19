project_id  = "your-project-id"
instance_id = "your-instance-name"
region      = "europe-west1"
database    = "postgres"
db_user     = "your-db-user"
db_password = "your-db-password"

database_flags = {
  "cloudsql_enable_private_ip" = "on",
  "cloudsql_enable_data_cache" = "on",
}

machine_type = "db-custom-8-32768"
storage_size_gb = 100
network      = "default"
subnetwork    = "default"
authorized_networks = ["10.0.0.0/24"]
require_ssl = true
backup_enabled = true
backup_retention_period = "1d"
encryption_key_name = "projects/PROJECT_ID/locations/global/keyRings/KEYRING_NAME/cryptoKeys/KEY_NAME"
private_network = "default"
private_ip      = "10.0.0.10"
deletion_protection = true
