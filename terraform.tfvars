pg_instance_name = "postgresql-instance"
project_id  = "august-storm-417111"
# instance_id = "your-instance-name"
region      = "europe-west1"
database    = "postgres"
database_version = "POSTGRES_14"
tier = "db-custom-1-3840"
pg_db_name = "master-db"

db_user     = "test-user1"
db_password = "abcde"

database_flags = {
  "cloudsql_enable_private_ip" = "on",
  "cloudsql_enable_data_cache" = "on",
}

machine_type = "db-custom-8-32768"
storage_size_gb = 10
network      = "default"
subnetwork    = "default"
authorized_networks = ["10.0.0.0/24"]
require_ssl = true
backup_enabled = true
backup_retention_period = "1d"
encryption_key_name = "test-enc-key"
private_network = "Groupnet"
private_ip      = "10.0.0.10"
deletion_protection = true
