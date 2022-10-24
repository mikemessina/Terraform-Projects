terraform {
  backend "azurerm" {
    resource_group_name = "terraformstate-rg"
    storage_account_name = "terrastatestore101022"
    container_name = "tfstate"
    key = "terraform.state"
  }
}

provider azurerm {
  version = "3.0.0"
  features {}
}

resource "azurerm_kubernetes_cluster" "CloudSkillsAKS" {
  name                = var.Name
  location            = var.location
  resource_group_name = var.resourceGroup
  dns_prefix          = "cloudskillsprefix"

  default_node_pool {
    name = "default"
    node_count = 1
    vm_size = "Standard_D2_v2"
  }
  service_principal {
    client_id     = var.clientID
    client_secret = var.clientSecret
  }

  tags = {
    Environment = "Development"
  }
}
