global-tags = {
  managedBy  = "Terraform"
}
network-resource-group = "rg-network"
networks = {
    vnet-01 = {
      address_space   = ["10.10.0.0/16"]
      dns_servers     = []
      tags = {
        description = "VNet 01 - Uses Azure default DNS"
      }
      subnets = {
        snet-01 = {
          address_prefixes = ["10.10.0.0/24"],
          delegation       = ""
        }
        snet-plan = {
          address_prefixes = ["10.10.1.0/24"],
          delegation       = "Microsoft.Web/serverFarms"
        }        
      }
    }
    vnet-02 = {
      address_space   = ["10.20.0.0/16","10.30.0.0/16"]
      dns_servers     = ["10.20.0.4","10.30.0.4"]
      tags = {
        description = "VNet 02 - Uses custom DNS"
      }
      subnets = {
        snet-01 = {
          address_prefixes = ["10.20.0.0/24"],
          delegation       = ""
        }
        snet-sqlmi = {
          address_prefixes = ["10.30.0.0/24"],
          delegation       = "Microsoft.Sql/managedInstances"
        }        
      }
    }
}