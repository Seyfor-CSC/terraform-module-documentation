locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-DNSZONE-NE-RG01"
    dns_1 = "sey.dnszone.dns01"
    dns_2 = "sey.dnszone.dns02"
  }

  dns = [
    {
      name                = local.naming.dns_1
      resource_group_name = azurerm_resource_group.rg.name
      soa_record = {
        email         = "random.com"
        expire_time   = 1800
        minimum_ttl   = 500
        refresh_time  = 1800
        retry_time    = 500
        serial_number = 1
        ttl           = 3800
      }
      tags = {}
    },
    {
      name                = local.naming.dns_2
      resource_group_name = azurerm_resource_group.rg.name

      tags = {}
    }
  ]
}
