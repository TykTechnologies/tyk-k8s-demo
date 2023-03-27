variable "cluster_location" {
	type = string
}

variable "cluster_machine_type" {
	type = string
}

variable "cluster_node_count" {
	type    = number
	default = 2
}

variable "enable_cloud_redis" {
	type    = bool
	default = false
}

variable "enable_cloud_storage" {
	type    = bool
	default = false
}
