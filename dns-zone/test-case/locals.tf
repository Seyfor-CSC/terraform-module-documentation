locals {
  location = "northeurope"

  naming = {
    rg    = "SEY-TERRAFORM-NE-RG01"
    dns_1 = "sey.terraform.dns01"
    dns_2 = "sey.terraform.dns02"
  }

  dns = [
    {
      name                = local.naming.dns_1
      resource_group_name = local.naming.rg
      soa_record = {
        email         = "random.com"
        host_name     = "ns1"
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
      resource_group_name = local.naming.rg

      tags = {}
    }
  ]
}
