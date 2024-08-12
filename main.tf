resource "azurerm_network_security_group" "this" {
  name                = "nsg-${var.suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location

  # Default security rules
  dynamic "security_rule" {
    for_each = var.enable_default_security_rules ? local.default_security_rules : []
    content {
      name                       = security_rule.value.name
      access                     = security_rule.value.access
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  # Normal security rules
  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                         = security_rule.value.name
      access                       = security_rule.value.access
      priority                     = security_rule.value.priority
      direction                    = security_rule.value.direction
      protocol                     = security_rule.value.protocol
      source_port_range            = security_rule.value.source_port_range
      source_port_ranges           = security_rule.value.source_port_ranges
      destination_port_range       = security_rule.value.destination_port_range
      destination_port_ranges      = security_rule.value.destination_port_ranges
      source_address_prefix        = security_rule.value.source_address_prefix
      source_address_prefixes      = security_rule.value.source_address_prefixes
      destination_address_prefix   = security_rule.value.destination_address_prefix
      destination_address_prefixes = security_rule.value.destination_address_prefixes
    }
  }
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "this" {
  for_each             = var.subnet_address_spaces
  name                 = "subnet-${each.key}-${var.suffix}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each                  = azurerm_subnet.this
  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.this.id
}
