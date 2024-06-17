# Summary

This is a module which creates the following resources:

- Virtual Network
- Subnets
- Network Resource Group

# Example

The following is an example of how to use the module:

```
resource "azurerm_resource_group" "this" {
  name     = "test-rg"
  location = "australiaeast"
}

module "vnet" {
  source              = "git::https://github.com/mason1999/terraform-vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  suffix              = "testing"
  address_space       = ["10.0.0.0/16"]
  subnet_address_spaces = {
    a = ["10.0.0.0/24"]
    b = ["10.0.1.0/24"]
  }
}
```
