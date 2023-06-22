locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    sa_1 = "seyterraformnesa01"
    sa_2 = "seyterraformnesa02"
  }

    sa = [
    {
      name                         = local.naming.sa_1
      location                     = local.location
      resource_group_name          = local.naming.rg
      account_tier                 = "Standard"
      account_replication_type     = "LRS"
      public_network_acces_enabled = false
      identity = {
        type = "SystemAssigned"
      }
      blob_properties = {
        delete_retention_policy = {
          days = 4
        }
        restore_policy = {
          days = 2
        }
        versioning_enabled  = true
        change_feed_enabled = true
        container_delete_retention_policy = {
          days = 4
        }
      }

      containers = [
        {
          name = "container1"
        },
        {
          name = "container2"
        }
      ]

      file_shares = [
        {
          name  = "fileshare1"
          quota = 50
        },
        {
          name  = "fileshare2"
          quota = 100
        }
      ]

      queues = [
        {
          name = "queue1"
        }
      ]

      tables = [
        {
          name = "table01"
        },
        {
          name = "table02"
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.sa_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.sa_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.sa_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["blob"]
            }
          ]
          private_dns_zone_group = [
            {
              name = azurerm_private_dns_zone.dns.name
              private_dns_zone_ids = [
                azurerm_private_dns_zone.dns.id
              ]
            }
          ]
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
        }
      ]

      tags = {}
    },
    {
      name                     = local.naming.sa_2
      location                 = local.location
      resource_group_name      = local.naming.rg
      account_tier             = "Standard"
      account_replication_type = "LRS"

      tags = {}
    }
  ]
}
