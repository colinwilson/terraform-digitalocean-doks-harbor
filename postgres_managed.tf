resource "digitalocean_database_user" "harbor" {
  cluster_id = var.pg_cluster_id == null ? digitalocean_database_cluster.harbor.id : var.pg_cluster_id
  name       = var.database_user_pg
}

resource "digitalocean_database_db" "harbor_notaryserver" {
  cluster_id = var.pg_cluster_id == null ? digitalocean_database_cluster.harbor.id : var.pg_cluster_id
  name       = "notary_server"
}

resource "digitalocean_database_db" "harbor_notarysigner" {
  cluster_id = var.pg_cluster_id == null ? digitalocean_database_cluster.harbor.id : var.pg_cluster_id
  name       = "notary_signer"
}

resource "digitalocean_database_db" "harbor_registry" {
  cluster_id = var.pg_cluster_id == null ? digitalocean_database_cluster.harbor.id : var.pg_cluster_id
  name       = "registry"
}

resource "digitalocean_database_cluster" "harbor" {
  name                 = "harbor-ext-postgres"
  engine               = "pg"
  version              = "13"
  size                 = var.database_size_pg
  region               = var.region
  private_network_uuid = var.vpc_uuid
  node_count           = var.database_node_count_pg
}