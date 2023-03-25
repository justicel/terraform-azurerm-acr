data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  dynamic "georeplications" {
    for_each = toset(var.georeplication_locations)
    content {
      location                = each.value
      zone_redundancy_enabled = true
      tags                    = {}
    }
  }

  tags = var.tags
}
