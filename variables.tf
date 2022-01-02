variable "doks_cluster_name" {
  type        = string
  description = "DOKS cluster name"
}

variable "postgres_cluster_name" {
  type        = string
  description = "Name of the existing Postgres Database Cluster"
  default     = ""
}

variable "redis_cluster_name" {
  type        = string
  description = "Name of the existing Redis Database Cluster"
  default     = ""
}

variable "harbor_chart_version" {
  type        = string
  description = "Harbor Helm chart version to install"
  default     = "1.8.1"
}

# Helm chart deployment can sometimes take longer than the default 5 minutes
variable "harbor_chart_timeout_seconds" {
  type    = number
  default = 800 # 10 minutes
}

variable "values_file" {
  type        = string
  description = "Name of the custom chart values file to use"
  default     = "values.yaml"
}

variable "harbor_expose_type" {
  type        = string
  description = "Set the method by which to expose the Harbor service."
  default     = "clusterip"

  validation {
    condition     = length(regexall("^clusterip|ingress|traefik$", var.harbor_expose_type)) > 0
    error_message = "Invalid Expose Type. Valid options are clusterip, ingress or traefik."
  }
}

variable "harbor_cert_cn" {
  type        = string
  description = "Common name for the automatically generated Harbor TLS cert"
  default     = "local"
}

variable "harbor_tls_secret_name" {
  type        = string
  description = "The name of the TLS secret"
  default     = ""
}

variable "harbor_tls_notary_secret_name" {
  type        = string
  description = "The name of the Notary TLS secret"
  default     = ""
}

variable "harbor_ext_url" {
  type        = string
  description = "Set Harbor's external URL"
  default     = "local" # Use kubectl port-forward to test access to Harbor web UI
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

# variable "redis_deployment" {
#   type        = string
#   description = "Deploy Redis on the DOKS cluster, or a managed Redis (managed) or none (none)."
#   default     = "managed"
#   validation {
#     condition     = length(regexall("^managed|cluster|none$", var.redis_deployment)) > 0
#     error_message = "Invalid Redis option. Valid options are managed, cluster or none."
#   }
# }

# variable "redis_chart_version" {
#   type        = string
#   description = "Redis Helm chart version to install"
#   default     = "15.6.4"
# }

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

# variable "redis_addr" {
#   type        = string
#   description = "Redis DB host IP/URL"
#   default     = null
# }

# variable "redis_password" {
#   type        = string
#   description = "Redis DB Password"
#   default     = null
# }

variable "spaces_access_id" {
  type        = string
  description = "DigitalOcean Spaces Access ID"
}

variable "spaces_secret_key" {
  type        = string
  description = "DigitalOcean Spaces Secret Key"
}
