output "vnet_id" {
  value = azurerm_virtual_network.this.id
}
output "subnet_ids" {
  value = { for k, v in var.subnet_address_spaces :
  k => azurerm_subnet.this[k].id }
}
