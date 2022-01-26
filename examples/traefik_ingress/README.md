# Traefik Ingress Deployment Example

This example illustrates how to use the `terraform-digitalocean-doks-harbor` module to deploy HA Harbor Registry on an existing DOKS cluster with [Traefik](https://traefik.io/traefik/) configured using its [Kubernetes Ingress provider](https://doc.traefik.io/traefik/providers/kubernetes-ingress/)

## Tutorial

[Configure Traefik to Proxy Harbor Registry on DigitalOcean Kubernetes via Terraform Modules](https://colinwilson.uk/2022/01/06/configure-traefik-to-proxy-harbor-registry-on-digitalocean-kubernetes-via-terraform-modules/)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| do_token | DigitalOcean Personal Access Token | string | N/A | yes |
| spaces_access_id | DigitalOcean Spaces Access ID | string | N/A | yes |
| spaces_secret_key | DigitalOcean Spaces Secret Key | string | N/A | yes |
| doks_cluster_name | Name of your DigitalOcean Kubernetes Cluster | string | N/A | yes |
| &nbsp; |
| harbor_ext_url | Set Harbor's external URL | string | `local` | no |
| harbor_expose_type | Expose Harbor deployment via `ClusterIP`, `Ingress` (ingress supports Traefik) | string | `clusterip` | no |
| harbor_tls_secret_name | Name of the TLS secret when using `harbor_expose_type`: `traefik` | string | empty | no |
| harbor_tls_notary_secret_name | Name of the Notary TLS secret when using `harbor_expose_type`: `traefik` | string | empty | no |
| values_file | Name of the custom chart values file to use (`path.root`) | string | `values.yaml` | no |
