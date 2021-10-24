output "vnets" {
  value       = azurerm_virtual_network.vnet
  description = "A map of VNets" 
}
output "snets" {
  value       = {
    for name, snet in azurerm_subnet.snet : snet.name => snet...
  }
  description = "A map of subnets"
}