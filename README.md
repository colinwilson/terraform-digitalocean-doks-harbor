# Terraform Harbor on DOKS (DigitalOcean Kubernetes) Module
A Terraform module to provision a highly available [Harbor Container Registry](https://goharbor.io/) on a DigitalOcean Kubernetes cluster (DOKS).

![](https://res.cloudinary.com/qunux/image/upload/v1639236111/harbor_portal_login_screenshot_2021-12-11_eymdvp.png)

## Features
* [x] Deploy a highly available [Harbor Container Registry](https://goharbor.io/) on a [DigitalOcean Kubernetes Cluster](https://www.digitalocean.com/products/kubernetes/) (DOKS).
* [x] DigitalOcean managed [PostgreSQL](https://www.digitalocean.com/products/managed-databases-postgresql/) (v13) & [Redis](https://www.digitalocean.com/products/managed-databases-redis/) (v6) Clusters auto-provisioned and configured.
* [x] [Spaces](https://www.digitalocean.com/products/spaces/) (S3 API compatible) bucket provisioned for image, chart, and job log storage.
* [x] Option to use existing Postgres & Redis clusters.
* [x] Harbor exposed by `ClusterIP` (default).
* [x] Expose Harbor by Ingress configured for use with Traefik.
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

![High Availability Harbor on DigitalOcean Kubernetes](https://res.cloudinary.com/qunux/image/upload/v1641018062/harbor_doks_architecture_v1.4_wtdics.svg)

1. DigitalOcean Kubernetes Cluster (DOKS)
2. Spaces bucket (for image, chart & job log storage)
3. Managed PostgreSQL Database Cluster
4. Managed Redis Database Cluster
5. Ingress Controller (e.g. Traefik) [optional]
6. DigitalOcean Cloud Load Balancer