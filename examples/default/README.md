# Default Deployment Example

This example illustrates how to use the `terraform-digitalocean-doks-harbor` module to deploy HA Harbor Registry on an existing DOKS cluster.



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| do_token | DigitalOcean Personal Access Token | string | N/A | yes |
| spaces_access_id | DigitalOcean Spaces Access ID | string | N/A | yes |
| spaces_secret_key | DigitalOcean Spaces Secret Key | string | N/A | yes |
| doks_cluster_name | Name of your DigitalOcean Kubernetes Cluster | string | N/A | yes |
