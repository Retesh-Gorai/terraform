variable "pg_instance_name" {
  description = "The name of the PostgreSQL instance"
  type        = string
}

variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
  # default = "august-storm-417111"
}

variable "database_version" {
  description = "The version of the PostgreSQL database"
  type        = string
}

variable "region" {
  description = "The region where the instance will be located"
  type        = string
}

variable "tier" {
  description = "The tier of the PostgreSQL instance"
  type        = string
}

variable "pg_db_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

# variable "project" {
#   type    = string
#   default = "august-storm-417111"
# }