locals {

  # Namespace
  namespace = var.create_namespace == true ? kubernetes_namespace.harbor[0].metadata.0.name : var.harbor_namespace

  # Spaces
  spaces_region   = length(regexall("^nyc3|ams3|fra1|sgp1|sfo3$", data.digitalocean_kubernetes_cluster.harbor.region)) > 0 ? data.digitalocean_kubernetes_cluster.harbor.region : "fra1"
  spaces_endpoint = "https://${local.spaces_region}.digitaloceanspaces.com"

  # Postgres

  provision_new_pg_database    = var.postgres_cluster_name == "" ? true : false
  provision_new_redis_database = var.redis_cluster_name == "" ? true : false

  postgres_cluster_id = var.postgres_cluster_name == "" ? digitalocean_database_cluster.harbor_postgres[0].id : data.digitalocean_database_cluster.postgres_cluster[0].id

  redis_cluster_id = var.redis_cluster_name == "" ? digitalocean_database_cluster.harbor_redis[0].id : data.digitalocean_database_cluster.redis_cluster[0].id

  pg_cluster_host = var.postgres_cluster_name == "" ? digitalocean_database_cluster.harbor_postgres[0].private_host : data.digitalocean_database_cluster.postgres_cluster[0].private_host
  pg_cluster_port = var.postgres_cluster_name == "" ? digitalocean_database_cluster.harbor_postgres[0].port : data.digitalocean_database_cluster.postgres_cluster[0].port


  redis_cluster_host = var.redis_cluster_name == "" ? digitalocean_database_cluster.harbor_redis[0].private_host : data.digitalocean_database_cluster.redis_cluster[0].private_host
  redis_cluster_port = var.redis_cluster_name == "" ? digitalocean_database_cluster.harbor_redis[0].port : data.digitalocean_database_cluster.redis_cluster[0].port

  redis_password = var.redis_cluster_name == "" ? digitalocean_database_cluster.harbor_redis[0].password : data.digitalocean_database_cluster.redis_cluster[0].password
}