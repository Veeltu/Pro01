locals {
  # Load the YAML file and decode it
  api_key = yamldecode(file("config.yaml"))["api_key"]

    config = yamldecode(file("config.yaml"))
}


resource "null_resource" "api_key_usage" {
  provisioner "local-exec" {
    command = "echo Using API key: ${local.api_key}"
  }
}

resource "null_resource" "vpc_name" {
  provisioner "local-exec" {
    command = "echo Using VPC key: ${local.config.resource.google_compute_network.main-network-1.name}"
  }
}
