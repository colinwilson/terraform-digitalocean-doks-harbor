variable "harbor_chart_version" {
  type        = string
  description = "Harbor Helm chart version to install"
  default     = "1.8.0"
}

variable "harbor_ext_url" {
  type        = string
  description = "Set Harbor's external URL"
  default     = "https://core.harbor.domain"
}

variable "redis_deployment" {
  type        = string
  description = "Deploy Redis on the DOKS cluster (cluster), or a managed Redis (managed) or none (none)."
  default     = "managed"
  validation {
    condition     = length(regexall("^managed|cluster|none$", var.redis_deployment)) > 0
    error_message = "Invalid Redis option. Valid options are managed, cluster or none."
  }
}

variable "redis_chart_version" {
  type        = string
  description = "Redis Helm chart version to install"
  default     = "15.6.4"
}

variable "region" {
  type        = string
  description = "Region in which to deploy Harbor. Default is fra1 (Frankfurt, Germany)"
  default     = "fra1"
  #   validation {
  #     condition     = length(regexall("^nyc1|sfo1|nyc2|ams2|sgp1|lon1|nyc3|ams3|fra1|tor1|sfo2|blr1|sfo3$", var.region)) > 0
  #     error_message = "Invalid region. Valid regions are nyc1, sfo1, nyc2, ams2, sgp1, lon1, nyc3, ams3, fra1, tor1, sfo2, blr1 or sfo3."
  #   }
}

variable "vpc_uuid" {
  type        = string
  description = "The ID of the VPC where Harbor the resources will be deployed."
  default     = null
}

variable "pg_cluster_id" {
  type        = string
  description = "Postgres DB cluster ID"
  default     = null
}

variable "pg_cluster_host" {
  type        = string
  description = "Postgres DB host IP/URL"
  default     = null
}

variable "pg_cluster_port" {
  type        = string
  description = "Postgres DB port"
  default     = null
}

variable "pg_cluster_password" {
  type        = string
  description = "Postgres DB password"
  default     = null
  sensitive   = true
}

variable "redis_cluster_id" {
  type        = string
  description = "Redis DB cluster ID"
  default     = null
}

variable "database_user_pg" {
  type        = string
  description = "Postgres database user name."
  default     = "harbor"
}

variable "database_size_pg" {
  type        = string
  description = "Database Droplet size associated with the Postgres cluster (ex. db-s-1vcpu-1gb)"
  default     = "db-s-1vcpu-1gb"
}

variable "database_node_count_pg" {
  type        = number
  description = "Number of nodes that comprise the Postgres database cluster"
  default     = 1
}

variable "database_size_redis" {
  type        = string
  description = "Database Droplet size associated with the Redis cluster (ex. db-s-1vcpu-1gb)"
  default     = "db-s-1vcpu-1gb"
}

variable "database_node_count_redis" {
  type        = number
  description = "Number of nodes that comprise the Redis database cluster"
  default     = 1
}

variable "redis_addr" {
  type        = string
  description = "Redis DB host IP/URL"
  default     = null
}

variable "redis_password" {
  type        = string
  description = "Redis DB Password"
  default     = null
}

variable "do_spaces_access_key" {
  type        = string
  description = "DigitalOcean Spaces Access Key"
}

variable "do_spaces_secret_key" {
  type        = string
  description = "DigitalOcean Spaces Secret Key"
}

variable "do_spaces_endpoint" {
  type        = string
  description = "DigitalOcean Spaces Endpoint"
  default     = "https://api.digitalocean.com"
}