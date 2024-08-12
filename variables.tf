variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The location where the virtual network is created. Changing this forces a new resource to be created."
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

variable "enable_default_security_rules" {
  type        = bool
  description = "(Optional) Flag to indicate whether to switch on the default rules. Defaults to false."
  default     = false
}

variable "security_rules" {
  description = <<EOF
  (Optional) List of inbound security rule blocks. An inbound security rule block supports the following:

  name - (Required) The name of the security rule.
  access - (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
  priority - (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
  direction - (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
  protocol - (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
  description - (Optional) A description for this rule. Restricted to 140 characters.
  source_port_range - (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
  source_port_ranges - (Optional) List of source ports or port ranges. This is required if source_port_range is not specified.
  destination_port_range - (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
  destination_port_ranges - (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified.
  source_address_prefix - (Optional) CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if source_address_prefixes is not specified.
  source_address_prefixes - (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
  source_application_security_group_ids - (Optional) A List of source Application Security Group IDs
  destination_address_prefix - (Optional) CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if destination_address_prefixes is not specified.
  destination_address_prefixes - (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
  destination_application_security_group_ids - (Optional) A List of destination Application Security Group IDs

  EOF
  type = list(object({
    name                                       = string
    access                                     = string
    priority                                   = number
    direction                                  = string
    protocol                                   = string
    description                                = optional(string, null)
    source_port_range                          = optional(string, null)
    source_port_ranges                         = optional(list(string), null)
    destination_port_range                     = optional(string, null)
    destination_port_ranges                    = optional(list(string), null)
    source_address_prefix                      = optional(string, null)
    source_address_prefixes                    = optional(list(string), null)
    destination_address_prefix                 = optional(string, null)
    destination_address_prefixes               = optional(list(string), null)
    source_application_security_group_ids      = optional(list(string), null)
    destination_application_security_group_ids = optional(list(string), null)
  }))

  default = []
}
