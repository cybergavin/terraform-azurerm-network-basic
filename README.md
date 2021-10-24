### terraform-azurerm-network

- A parameterized deployment of Virtual Networks and subnets on Microsoft Azure
- Reads input data from the variable `networks`, which represents a map of Virtual Networks, with each Virtual Network containing a map of subnets.
- In order to apply the same tags across multiple networks, use the `global_tags` variable to store such common tags in a map.
- Can be easily extended to include other VNet and Subnet parameters as supported by the **azurerm_virtual_network** and **azurerm_subnet** Terraform resources.
<br />
<br />

### Structure of the `networks` variable
```
networks = {
    <vnet_name> = {
      address_space   = [<vnet_cidr_list>]
      dns_servers     = [<custom_dns_list>]
      tags = {
        description = "<vnet_description>"
      }
      subnets = {
        <subnet_name> = {
          address_prefixes = [<subnet_cidr_prefix>],
          delegation       = "<azure_paas_service>"
        }
      }
    }
}
```
<br />
<br /> 

**NOTE:** The resource group name used as the value of the `network-resource-group` variable must exist before using this module.
<br />
<br /> 

### Example:

Refer examples folder
