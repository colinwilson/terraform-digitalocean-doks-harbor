variable "doks_cluster_name" {
  type        = string
  description = "DOKS cluster name"
}

variable "harbor_chart_version" {
  type        = string
  description = "Harbor Helm chart version to install"
  default     = "1.8.1"
}

variable "harbor_cert_cn" {
  type        = string
  description = "Common name for the automatically generated Harbor TLS cert"
  default     = "harbor.local"
}

variable "harbor_ext_url" {
  type        = string
  description = "Set Harbor's external URL"
  default     = "https://harbor.local" # Use kubectl port-forward to test access to Harbor web UI
}

variable "harbor_admin_password" {
  type        = string
  description = "The initial password of the Harbor admin"
  default     = "Harbor12345"
}

variable "firewall_databases" {
  type        = bool
  description = "Firewall both Postgres and Redis databases. Connections permitted from the specified DOKS cluster only"
  default     = true
}

variable "redis_deployment" {
  type        = string
  description = "Deploy Redis on the DOKS cluster, or a managed Redis (managed) or none (none)."
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

variable "spaces_access_id" {
  type        = string
  description = "DigitalOcean Spaces Access ID"
}

variable "spaces_secret_key" {
  type        = string
  description = "DigitalOcean Spaces Secret Key"
}

# variable "spaces_name" {
#   type        = string
#   description = "DigitalOcean Spaces bucket name."
#   default     = null
# }

# variable "spaces_region" {
#   type        = string
#   description = "Region in which to deploy Spaces storage for Harbor. Default is the same region your DOKS cluster is located in."
#   default     = "fra1"
#   validation {
#     condition     = length(regexall("^nyc3|ams3|fra1|sgp1|sfo3$", var.spaces_region)) > 0
#     error_message = "Invalid region. DigitalOcean Spaces are available in regions nyc3, sfo3, ams3, sgp1 & fra1."
#   }
# }

# variable "spaces" {
#   description = "DigitalOcean Spaces access credentials."
#   type = map(
#     object({
#       access_id  = string
#       secret_key = string
#     })
#   )
# }

# variable "spaces_endpoint" {
#   type        = string
#   description = "DigitalOcean Spaces Endpoint"
#   default     = "https://api.digitalocean.com"
# }