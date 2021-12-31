resource "digitalocean_database_user" "harbor" {
  cluster_id = local.postgres_cluster_id
  name       = var.database_user_pg
}

resource "digitalocean_database_db" "harbor_notaryserver" {
  cluster_id = local.postgres_cluster_id
  name       = "notary_server"
}

resource "digitalocean_database_db" "harbor_notarysigner" {
  cluster_id = local.postgres_cluster_id
  name       = "notary_signer"
}

resource "digitalocean_database_db" "harbor_registry" {
  cluster_id = local.postgres_cluster_id
  name       = "registry"
}

resource "digitalocean_database_cluster" "harbor_postgres" {

  count = var.postgres_cluster_name == "" ? 1 : 0

  name                 = "harbor-postgres"
  engine               = "pg"
  version              = "13"
  size                 = var.database_size_pg
  region               = data.digitalocean_kubernetes_cluster.harbor.region
  private_network_uuid = data.digitalocean_kubernetes_cluster.harbor.vpc_uuid
  node_count           = var.database_node_count_pg
}

resource "digitalocean_database_firewall" "harbor_postgres" {

  count = var.firewall_databases == true ? 1 : 0

  cluster_id = local.postgres_cluster_id
  rule {
    type  = "k8s"
    value = data.digitalocean_kubernetes_cluster.harbor.id
  }
}