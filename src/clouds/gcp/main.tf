provider "google" {
	project = var.project
}

data "google_client_config" "this" {}

resource "google_container_cluster" "this" {
	name     = "tyk-demo-${var.cluster_location}"
	location = var.cluster_location

	initial_node_count = var.cluster_node_count
	node_config {
		machine_type = var.cluster_machine_type
	}
}
