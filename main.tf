# locals {
#   read_replica_ip_configuration = {
#     ipv4_enabled       = false
#     require_ssl        = true
#     private_network    = null
#     allocated_ip_range = null
#     authorized_networks = [
    
#     ]
#   }
# }

data "google_secret_manager_secret_version" "ssl_cert" {
  provider = google-beta
  project  = var.project_id
  secret   = "my-ssl-cert"  # Specify the name of the secret containing SSL certificates
  version  = "latest"       # You may specify a specific version if needed
}

resource "google_service_networking_connection" "default" {
  network                 = "projects/PROJECT_ID/global/networks/Groupnet"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["10.0.0.0/28"]
}


resource "google_compute_network_peering_routes_config" "peering_routes" {
  project              = var.project_id
  peering              = google_service_networking_connection.default.peering
  network              = "projects/PROJECT_ID/global/networks/Groupnet"
  import_custom_routes = true
  export_custom_routes = true
}


module "cloud_sql_instance" {
  module_depends_on = [google_service_networking_connection.default]
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "~> 20.0"

  # name = var.pg_instance_name
  # random_instance_name = true
  # project_id  = var.project_id
  # instance_id = var.instance_id
  # region      = var.region
  # database    = var.database
  # db_user     = var.db_user
  # db_password = var.db_password

  # # Database flags
  # database_flags = var.database_flags

  # # Machine type
  # machine_type = var.machine_type

  # # Storage
  # storage_size_gb = var.storage_size_gb

  # # Network
  # network      = var.network
  # subnetwork    = var.subnetwork
  # authorized_networks = var.authorized_networks

  # # SSL
  # require_ssl = var.require_ssl

  # # Backups
  # backup_enabled = var.backup_enabled
  # backup_retention_period = var.backup_retention_period

  # # Encryption
  # encryption_key_name = var.encryption_key_name

  # # Private service access
  # private_network = var.private_network
  # private_ip      = var.private_ip

  # # Other settings
  # deletion_protection = var.deletion_protection

  name                 = var.pg_instance_name
  random_instance_name = true
  project_id           = var.project_id
  database_version     = var.database_version
  region               = var.region

  // Master configurations
  tier                            = var.tier
  zone                            = "europe-west1-b"
  availability_type               = "REGIONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"

  deletion_protection = true

  # database_flags = [{ name = "autovacuum", value = "off" }]

  user_labels = {
    creation_type = "automated"
  }

  ip_configuration = {
    ipv4_enabled       = false
    require_ssl        = true
    private_network    = "projects/PROJECT_ID/global/networks/Groupnet"
    allocated_ip_range = null
    authorized_networks = [
      # {
      #   name  = "${var.project_id}-cidr"
      #   value = var.pg_ha_external_ip_range
      # },
    ]
     # Use the retrieved SSL certificates
    ssl_certificates = [data.google_secret_manager_secret_version.ssl_cert.secret_data]
  }

  backup_configuration = {
    enabled                        = true
    start_time                     = "18:30"
    # location                       = null
    point_in_time_recovery_enabled = true
    # transaction_log_retention_days = null
    retained_backups               = 7
    # retention_unit                 = "COUNT"
  }

  # // Read replica configurations
  # read_replica_name_suffix = "-test-ha"
  # read_replicas = [
  #   {
  #     name                  = "0"
  #     zone                  = "europe-west1-a"
  #     availability_type     = "REGIONAL"
  #     tier                  = var.tier
  #     ip_configuration      = local.read_replica_ip_configuration
  #     database_flags        = [{ name = "autovacuum", value = "off" }]
  #     disk_autoresize       = null
  #     disk_autoresize_limit = null
  #     disk_size             = null
  #     disk_type             = "PD_SSD"
  #     user_labels           = { bar = "baz" }
  #     encryption_key_name   = "test-encryp-key"
  #   },
  # ]

  db_name      = var.pg_db_name
  db_charset   = "UTF8"
  db_collation = "en_US.UTF8"

  additional_databases = [
    {
      name      = "${var.pg_db_name}-additional"
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
  ]

  user_name     = "tftest"
  user_password = "foobar"

  additional_users = [
    {
      name            = "tftest2"
      password        = "abcdefg"
      host            = "%"
      random_password = false
    },
    {
      name            = "tftest3"
      password        = "abcdefg"
      host            = "%"
      random_password = false
    },
  ]

  # location_preference {
  #   zone = "us-central1-c"
  #   follow_gae_application = true
  # }
  
  # location_preference {
  #   zone = "us-central1-d"
  #   follow_gae_application = true
  # }

}