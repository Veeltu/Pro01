terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.47.0"
    }
  }
}

locals {
  provider_config = yamldecode(file("file01.yaml"))
  vpc_config      = yamldecode(file("file02.yaml"))
  subnet_config   = yamldecode(file("file03.yaml"))
}

provider "google" {
  project = local.provider_config.provider.google.project
  region  = local.provider_config.provider.google.region
}

resource "google_compute_network" "vpc-network-1" {
  name                    = local.vpc_config.resource.google_compute_network.vpc-network-1.name
  auto_create_subnetworks = local.vpc_config.resource.google_compute_network.vpc-network-1.auto_create_subnetworks
}

resource "google_compute_network" "vpc-network-2" {
  name                    = local.vpc_config.resource.google_compute_network.vpc-network-2.name
  auto_create_subnetworks = local.vpc_config.resource.google_compute_network.vpc-network-2.auto_create_subnetworks
}

resource "google_compute_subnetwork" "subnet-1" {
  name          = local.subnet_config.resource.google_compute_subnetwork.subnet-1.name
  ip_cidr_range = local.subnet_config.resource.google_compute_subnetwork.subnet-1.ip_cidr_range
  region        = local.subnet_config.resource.google_compute_subnetwork.subnet-1.region
  network       = google_compute_network.vpc-network-1.id
}

resource "google_compute_subnetwork" "subnet-2" {
  name          = local.subnet_config.resource.google_compute_subnetwork.subnet-2.name
  ip_cidr_range = local.subnet_config.resource.google_compute_subnetwork.subnet-2.ip_cidr_range
  region        = local.subnet_config.resource.google_compute_subnetwork.subnet-2.region
  network       = google_compute_network.vpc-network-2.id
}
