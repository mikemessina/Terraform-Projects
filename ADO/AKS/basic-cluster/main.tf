terraform {
  backend "azurerm" {
    resource_group_name = "terraformstate-rg"
    storage_account_name = "tfstatemwm102422"
    container_name = "tfstate"
    key = "terraform.state"
  }
}
provider "azurerm" {
  # version = "3.0.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-k8s-rg"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.prefix}-k8s"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}