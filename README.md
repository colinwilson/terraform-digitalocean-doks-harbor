# Terraform Harbor on DOKS (DigitalOcean Kubernetes) Module
A Terraform module to provision a highly available [Harbor Container Registry](https://goharbor.io/) on a DigitalOcean Kubernetes cluster (DOKS).

![](https://res.cloudinary.com/qunux/image/upload/v1639236111/harbor_portal_login_screenshot_2021-12-11_eymdvp.png)

## Compatibility/Requirements

* Requires [Terraform](https://www.terraform.io/downloads.html) 0.15 or higher.
* A DigitalOcean account and [personal access token](https://docs.digitalocean.com/reference/api/create-personal-access-token/) for accessing the DigitalOcean API - [Use this referral link for $100 free credit](https://m.do.co/c/6b3bf6d79f7d)
* Spaces [access ID & secret key](https://docs.digitalocean.com/products/spaces/how-to/manage-access/#access-keys)
* A Pre-provisioned [DigitalOcean Kubernetes Cluster](https://docs.digitalocean.com/products/kubernetes/) (DOKS) [**version <span>&#8805;</span> 1.10**].

## Tutorial

[Deploy a Harbor Container Registry with High Availability on DigitalOcean via Terraform](https://colinwilson.uk/2021/12/11/deploy-a-harbor-container-registry-with-high-availability-on-digitalocean-via-terraform/)

