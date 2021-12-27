resource "random_id" "spaces_bucket_id" {
  byte_length = 4
}

resource "digitalocean_spaces_bucket" "harbor" {
  name   = "doks-harbor-storage-${random_id.spaces_bucket_id.hex}"
  region = local.spaces_region
}