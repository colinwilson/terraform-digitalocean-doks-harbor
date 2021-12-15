resource "digitalocean_spaces_bucket" "harbor" {
  name   = "${var.region}-doks-harbor-storage"
  region = var.region
}