locals {
  inbound_nsg_rules = {
    AllowHTTP = {
      priority               = 1000
      destination_port_range = "80"
    }
    AllowHTTPS = {
      priority               = 1100
      destination_port_range = "443"
    }
    AllowSSH = {
      priority               = 1200
      destination_port_range = "22"
    }
    AllowSSH = {
      priority               = 1300
      destination_port_range = "3389"
    }
  }
}
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "this" {
  name                = "nsg-${var.suffix}"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
}

resource "azurerm_network_security_rule" "this_inbound_nsg_rules" {
  for_each                    = local.inbound_nsg_rules
  name                        = each.key
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.this.name
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.suffix}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "this" {
  for_each             = var.subnet_address_spaces
  name                 = "subnet-${each.key}-${var.suffix}"
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value
}
