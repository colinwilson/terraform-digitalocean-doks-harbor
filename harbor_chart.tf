resource "helm_release" "harbor" {
  name             = "harbor"
  namespace        = var.harbor_namespace
  create_namespace = true
  repository       = "https://helm.goharbor.io"
  chart            = "harbor"
  version          = var.harbor_chart_version

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.harbor_chart_timeout_seconds

  values = [fileexists("${path.root}/${var.values_file}") == true ? file("${path.root}/${var.values_file}") : templatefile("${path.module}/custom_chart_values/${var.harbor_expose_type}.yaml.tftpl", {

    # Harbor chart custom values
    harbor_cert_cn                = var.harbor_cert_cn
    harbor_ext_url                = var.harbor_ext_url
    harbor_tls_secret_name        = var.harbor_tls_secret_name
    harbor_tls_notary_secret_name = var.harbor_tls_notary_secret_name
    harbor_admin_password         = var.harbor_admin_password

    # DigitalOcean Spaces access parameter
    spaces_access_id   = var.spaces_access_id
    spaces_secret_key  = var.spaces_secret_key
    spaces_endpoint    = local.spaces_endpoint
    spaces_bucket_name = digitalocean_spaces_bucket.harbor.name

    # DigitalOcean Postgres connection parameters
    pg_cluster_host     = local.pg_cluster_host
    pg_cluster_port     = local.pg_cluster_port
    pg_cluster_username = var.database_user_pg
    pg_cluster_password = digitalocean_database_user.harbor.password

    # DigitalOcean Redis connection parameters
    # redis_addr = var.redis_deployment == "managed" ? "redis-proxy:6379" : "${helm_release.redis.name}-master:6379" #"${digitalocean_database_cluster.harbor_redis.private_host}:${digitalocean_database_cluster.harbor_redis.port}"
    redis_addr     = "redis-proxy:6379" # "${helm_release.redis.name}-master:6379" #"${digitalocean_database_cluster.harbor_redis.private_host}:${digitalocean_database_cluster.harbor_redis.port}"
    redis_password = local.redis_password
    # redis_addr = "${helm_release.redis.name}-master:6379"
  })]
}