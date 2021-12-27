# resource "helm_release" "redis" {
#   name       = "aigisuk-terraform-redis-v6-2-6"
#   namespace  = kubernetes_namespace.harbor.metadata.0.name
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "redis"
#   version    = var.redis_chart_version

#   set {
#     name  = "auth.enabled"
#     value = false
#   }

#   set {
#     name  = "replica.replicaCount"
#     value = 2
#   }

#   set {
#     name  = "replica.persistence.size"
#     value = "2Gi"
#   }

#   set {
#     name  = "master.persistence.size"
#     value = "2Gi"
#   }
# }