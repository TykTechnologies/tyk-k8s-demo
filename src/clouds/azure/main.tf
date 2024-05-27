provider "azurerm" {
	features {}
}

resource "azurerm_resource_group" "this" {
	name     = "tyk-demo-${var.cluster_location}"
	location = var.cluster_location
}

resource "azurerm_kubernetes_cluster" "this" {
	name                = azurerm_resource_group.this.name
	location            = azurerm_resource_group.this.location
	kubernetes_version  = "1.28"
	resource_group_name = azurerm_resource_group.this.name
	dns_prefix          = replace(azurerm_resource_group.this.name, "_", "-")

	default_node_pool {
		name       = "default"
		node_count = var.cluster_node_count
		vm_size    = var.cluster_machine_type
	}

	identity {
		type = "SystemAssigned"
	}
}
