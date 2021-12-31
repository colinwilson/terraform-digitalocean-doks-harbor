data "digitalocean_kubernetes_cluster" "harbor" {
  name = var.doks_cluster_name
}

data "digitalocean_database_cluster" "postgres_cluster" {

  count = local.provision_new_pg_database == true ? 0 : 1

  name = var.postgres_cluster_name
}

data "digitalocean_database_cluster" "redis_cluster" {

  count = local.provision_new_redis_database == true ? 0 : 1

  name = var.redis_cluster_name
}