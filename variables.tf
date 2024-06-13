variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
}

variable "suffix" {
  type        = string
  description = "(Required) The suffix to append to the name of all the resources in this module."
}

variable "address_space" {
  type        = list(string)
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
}

variable "subnet_address_spaces" {
  type        = map(list(string))
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
}
