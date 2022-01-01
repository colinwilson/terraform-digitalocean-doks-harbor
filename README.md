# Terraform Harbor on DOKS (DigitalOcean Kubernetes) Module
A Terraform module to provision a highly available [Harbor Container Registry](https://goharbor.io/) on a DigitalOcean Kubernetes cluster (DOKS). (Part of the [DigitalOcean Kubernetes Challange 2021](https://www.digitalocean.com/community/pages/kubernetes-challenge))

![](https://res.cloudinary.com/qunux/image/upload/v1639236111/harbor_portal_login_screenshot_2021-12-11_eymdvp.png)

## Features
* [x] Deploy a highly available [Harbor Container Registry](https://goharbor.io/) on a [DigitalOcean Kubernetes Cluster](https://www.digitalocean.com/products/kubernetes/) (DOKS).
* [x] DigitalOcean managed [PostgreSQL](https://www.digitalocean.com/products/managed-databases-postgresql/) (v13) & [Redis](https://www.digitalocean.com/products/managed-databases-redis/) (v6) Clusters auto-provisioned and configured.
* [x] [Spaces](https://www.digitalocean.com/products/spaces/) (S3 API compatible) bucket provisioned for image, chart, and job log storage.
* [x] Option to use existing Postgres & Redis clusters.
* [x] Harbor exposed by `ClusterIP` (default).
* [x] Expose Harbor by Ingress configured for use with Traefik.
* [ ] Post deployment status via `outputs.tf`
* [ ] Deploy `redis-proxy` DaemonSet pods only on nodes that require them.
* [ ] Expose  Harbor via NodePort.
* [ ] Expose Harbor via LoadBalancer.
* [ ] Option to deploy PostgreSQL & Redis on the cluster instead of provisioning managed clusters (maintains HA).
## Compatibility/Requirements

* Requires [Terraform](https://www.terraform.io/downloads.html) 0.15 or higher.
* A DigitalOcean account and [personal access token](https://docs.digitalocean.com/reference/api/create-personal-access-token/) for accessing the DigitalOcean API - [Use this referral link for $100 free credit](https://m.do.co/c/6b3bf6d79f7d)
* Spaces [access ID & secret key](https://docs.digitalocean.com/products/spaces/how-to/manage-access/#access-keys)
* A Pre-provisioned [DigitalOcean Kubernetes Cluster](https://docs.digitalocean.com/products/kubernetes/) (DOKS) [**version <span>&#8805;</span> 1.10**].

## Tutorial

[Deploy a Harbor Container Registry with High Availability on DigitalOcean via Terraform](https://colinwilson.uk/2021/12/11/deploy-a-harbor-container-registry-with-high-availability-on-digitalocean-via-terraform/)

## Architecture

The default deployment of this module provisions the below resources on an existing DigitalOcean Kubernetes Cluster (**1**) (which itself can be provisioned by a [Terraform module](https://github.com/aigisuk/terraform-digitalocean-doks)).

![High Availability Harbor on DigitalOcean Kubernetes](https://res.cloudinary.com/qunux/image/upload/v1641050956/harbor_doks_architecture_v1.6_ot6c17.svg)

**1.** DigitalOcean Kubernetes Cluster (DOKS)<br>
**2.** Spaces bucket (for image, chart & job log storage)<br>
**3.** Managed PostgreSQL Database Cluster (single node)<br>
**4.** Managed Redis Database Cluster (single node)<br>
**5.** Harbor Service (ClusterIP)<br>

The module can also be configured to expose Harbor via Ingress with Traefik as the ingress controller, a valid TLS certificate via cert-manager and a [DigitalOcean Cloud Load Balancer](https://www.digitalocean.com/products/load-balancer/) (see this example TBA):

![High Availability Harbor on DigitalOcean Kubernetes with Traefik Ingress Controller](https://res.cloudinary.com/qunux/image/upload/v1641020223/harbor_doks_architecture_v1.5_qsa44i.svg)

**5.** Ingress Controller (e.g. Traefik)<br>
**6.** DigitalOcean Cloud Load Balancer<br>

## Usage

Basic usage of this module is as follows:

```
module "harbor" {
  source = "colinwilson/doks-harbor/digitalocean"

  doks_cluster_name = var.doks_cluster_name

  spaces_access_id  = var.spaces_access_id
  spaces_secret_key = var.spaces_secret_key
}
```

*See the [examples directory](./examples/) for details & additional deployment scenarios*

Example output:
```
TBA
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| do_token | DigitalOcean Personal Access Token | string | N/A | yes |
| spaces_access_id | DigitalOcean Spaces Access ID | string | N/A | yes |
| spaces_secret_key | DigitalOcean Spaces Secret Key | string | N/A | yes |
| doks_cluster_name | Name of your DigitalOcean Kubernetes Cluster | string | N/A | yes |
| postgres_cluster_name | Name of existing DO Managed Postgres Cluster | string | empty | no |
| redis_cluster_name | Name of existing DO Managed Redis Cluster | string | empty | no |
| harbor_chart_version | Harbor chart version to deploy | string | `1.8.1` | no |
| harbor_chart_timeout_seconds | Harbor chart deployment timeout (secs) | number | `800` | no |
| harbor_expose_type | Expose Harbor deployment via `ClusterIP`, `Ingress` (ingress supports Traefik) | string | `clusterip` | no |
| harbor_cert_cn | Common name for the automatically generated Harbor TLS cert when using `harbor_expose_type`: `clusterip` | string | `local` | no |
| harbor_tls_secret_name | Name of the TLS secret when using `harbor_expose_type`: `traefik` | string | empty | no |
| harbor_tls_notary_secret_name | Name of the Notary TLS secret when using `harbor_expose_type`: `traefik` | string | empty | no |
| harbor_ext_url | Set Harbor's external URL | string | `local` | no |
| harbor_admin_password | Initial password of the default Harbor user `admin` | string | `Harbor12345` | no |
| firewall_databases | Firewall both Postgres and Redis databases. Connections permitted from the specified DOKS cluster only | bool | `true` | no |
| database_user_pg | Postgres database user name | string | `harbor` | no |
| database_size_pg | Database Droplet size associated with the provisioned Postgres cluster (ex. `db-s-1vcpu-1gb`) | string | `db-s-1vcpu-1gb` | no |
| database_node_count_pg | Number of nodes ot provision for the Postgres database cluster | number | `1` | no |
| database_size_redis | Database Droplet size associated with the provisioned Redis cluster (ex. `db-s-1vcpu-1gb`) | string | `db-s-1vcpu-1gb` | no |
| database_node_count_redis | Number of nodes ot provision for the Redis database cluster | number | `1` | no |

## Outputs

**TBA**

