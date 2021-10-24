This example does the following:

- Creates 2 VNets vnet-01 and vnet-02
- vnet-01 uses a single address space and Azure's default DNS
- vnet-02 uses 2 address spaces and custom DNS servers
- Creates 2 subnets in each VNet
- The 2<sup>nd</sup> subnet in each VNet is a delegated subnet, delegated to serverFarms (App Service Plans) and SQL Managed Instances.

**NOTE:** The resource group `rg-network` must exist before executing a `terraform apply` for this example.