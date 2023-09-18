locals {
  location = "northeurope"

  naming = {
    rg   = "SEY-TERRAFORM-NE-RG01"
    aa_1 = "SEY-TERRAFORM-NE-AA01"
    aa_2 = "SEY-TERRAFORM-NE-AA02"
    ar_1 = "Get-LinuxVirtualMachine"
    ar_2 = "Get-WindowsVirtualMachine"
    as_1 = "hour"
    as_2 = "weekday"
  }

  aa = [
    {
      name                = local.naming.aa_1
      location            = local.location
      resource_group_name = local.naming.rg
      sku_name            = "Basic"
      identity = {
        type = "SystemAssigned"
      }

      runbook = [
        {
          name         = local.naming.ar_1
          runbook_type = "PowerShell"
          log_progress = false
          log_verbose  = false
          publish_content_link = {
            uri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/c4935ffb69246a6058eb24f54640f53f69d3ac9f/101-automation-runbook-getvms/Runbooks/Get-AzureVMTutorial.ps1"
          }

          job_schedule = [
            {
              schedule_name = local.naming.as_1
            },
            {
              schedule_name = local.naming.as_2
            }
          ]
        },
        {
          name         = local.naming.ar_2
          runbook_type = "PowerShell"
          log_progress = false
          log_verbose  = false
          content      = file("./sample_script.ps1")

          job_schedule = [
            {
              schedule_name = local.naming.as_2
            }
          ]
        }
      ]

      schedule = [
        {
          name      = local.naming.as_1
          frequency = "Hour"
        },
        {
          name        = local.naming.as_2
          frequency   = "Week"
          interval    = 1
          timezone    = "Europe/Prague"
          description = "This is an example schedule"
          week_days   = ["Friday"]
        }
      ]

      private_endpoint = [
        {
          name                          = "${local.naming.aa_1}-PE01"
          subnet_id                     = azurerm_subnet.subnet.id
          custom_network_interface_name = "${local.naming.aa_1}-PE01.nic"
          private_service_connection = [
            {
              name                 = "${local.naming.aa_1}-PE01-connection"
              is_manual_connection = false
              subresource_names    = ["Webhook"]
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
      name                = local.naming.aa_2
      location            = local.location
      resource_group_name = local.naming.rg
      sku_name            = "Free"

      tags = {}
    }
  ]
}
