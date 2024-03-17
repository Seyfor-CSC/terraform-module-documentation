locals {
  location = "northeurope"

  naming = {
    rg      = "SEY-TERRAFORM-NE-RG01"
    evhns_1 = "SEY-TERRAFORM-NE-EVHNS01"
    evhns_2 = "SEY-TERRAFORM-NE-EVHNS02"
    evh_1   = "sey-terraform-ne-evh01"
    evh_2   = "sey-terraform-ne-evh02"
  }

  evhns = [
    {
      name                = local.naming.evhns_1
      location            = local.location
      resource_group_name = local.naming.rg
      sku                 = "Standard"
      identity = {
        type = "SystemAssigned"
      }

      eventhub = [
        {
          name              = local.naming.evh_1
          partition_count   = 4
          message_retention = 7

          eventhub_consumer_group = [
            {
              name = "consumergroup1"
            },
            {
              name = "consumergroup2"
            }
          ]
          eventhub_authorization_rule = [
            {
              name   = "CustomAccessKey"
              manage = true
            }
          ]
        },
        {
          name              = local.naming.evh_2
          partition_count   = 4
          message_retention = 7
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.evhns_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.evhns_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.evhns_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["namespace"]
            }
          ]
          private_dns_zone_group = {
            name = azurerm_private_dns_zone.dns.name
            private_dns_zone_ids = [
              azurerm_private_dns_zone.dns.id
            ]
          }
        }
      ]

      monitoring = [
        {
          diag_name                  = "Monitoring"
          log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
          categories = {
            runtime_audit_logs = true
          }
        }
      ]

      tags = {}
    },
    {
      name                = local.naming.evhns_2
      location            = local.location
      resource_group_name = local.naming.rg
      sku                 = "Standard"

      tags = {}
    }
  ]
}
