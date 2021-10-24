###############################################################################################
# Local variables
###############################################################################################
locals {
  # List of VNets from the 'networks' map variable
  vnet-list = [
    for vnet-key, vnet in var.networks : {
      vnet-key      = vnet-key
      address_space = vnet.address_space
      dns_servers   = vnet.dns_servers      
      tags          = vnet.tags
    }
  ]
  # List of Subnets within all VNets from the 'networks' map variable
  subnet-list = flatten([
    for vnet-key, vnet in var.networks : [
      for subnet-key, subnet in vnet.subnets : {
        vnet-key           = vnet-key
        subnet-key         = subnet-key
        address_space      = vnet.address_space
        address_prefixes   = subnet.address_prefixes
        delegation         = subnet.delegation != "" ? subnet.delegation : null
      }
    ]
  ])
}
###############################################################################################
# Create Virtual Networks
###############################################################################################
resource "azurerm_virtual_network" "vnet" {
  for_each = {
    for net in local.vnet-list : net.vnet-key => net
  }

    name                = each.key
    address_space       = each.value.address_space
    dns_servers         = each.value.dns_servers
    location            = var.region-name
    tags                = lookup(each.value, "tags", null) == null ? var.global-tags : merge(var.global-tags, each.value.tags)
    resource_group_name = var.network-resource-group
}
###############################################################################################
# Create Subnets
###############################################################################################
resource "azurerm_subnet" "snet" {
  for_each = {
    for net in local.subnet-list : "${net.vnet-key}.${net.subnet-key}" => net
  }

    name                     = each.value.subnet-key
    resource_group_name      = var.network-resource-group
    virtual_network_name     = azurerm_virtual_network.vnet[each.value.vnet-key].name
    address_prefixes         = each.value.address_prefixes

    dynamic "delegation" {
      for_each = each.value.delegation[*]

      content {
        name = "delegation"
        service_delegation {
          name    = each.value.delegation
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
}