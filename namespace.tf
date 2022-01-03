resource "kubernetes_namespace" "harbor" {

  count = var.create_namespace == true ? 1 : 0
  metadata {
    name = var.harbor_namespace
  }
}