# Introduction
Kubernetes Cluster module can deploy these resources:
* azurerm_kubernetes_cluster (required)
* azurerm_kubernetes_cluster_node_pool (optional)
* azurerm_monitor_diagnostic_setting (optional)

Example variables structure is located in [variables.md](variables.md).

Example use case is located in [test-case/locals.tf](test-case/locals.tf).

You can also see [changelog](CHANGELOG.md).

Terraform documentation:

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/kubernetes_cluster

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/kubernetes_cluster_node_pool

https://registry.terraform.io/providers/hashicorp/azurerm/4.33.0/docs/resources/monitor_diagnostic_setting

&nbsp;

> **WARNING:** AzureRM provider had been updated to a new major version. Many breaking changes were implemented. See the [providers guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide) for more information.

# Terraform Import
There are a few things you need to do to import resources into .tfstate. In the example below there are resources which can be imported within the module. You may need to modify these commands to the OS on which they will be running (Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/import#example-import-into-resource-configured-with-for_each) for additional details).
### Kubernetes Cluster
* terraform import '`<path-to-module>`.azurerm_kubernetes_cluster.kubernetes_cluster["`<kubernetes-cluster-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.ContainerService/managedClusters/`<kubernetes-cluster-name>`'
### Kubernetes Cluster Node Pool
* terraform import '`<path-to-module>`.azurerm_kubernetes_cluster_node_pool.kubernetes_cluster_node_pool["`<kubernetes-cluster-name>`_`<node-pool-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.ContainerService/managedClusters/`<kubernetes-cluster-name>`/agentPools/`<node-pool-name>`'
### Diagnostic Setting
* terraform import '`<path-to-module>`.azurerm_monitor_diagnostic_setting.diagnostic_setting["`<kubernetes-cluster-name>`_`<diag-name>`"]' '/subscriptions/`<subscription-id>`/resourceGroups/`<resource-group-name>`/providers/Microsoft.ContainerService/managedClusters/`<kubernetes-cluster-name>`|`<diag-name>`'

 > **_NOTE:_** `<path-to-module>` is terraform logical path from root. e.g. _module.kubernetes\_cluster_

&nbsp;

# Outputs
## Structure

| Output Name | Value                        | Comment                                                 |
| ----------- | ---------------------------- | ------------------------------------------------------- |
| outputs     | name                         |                                                         |
|             | id                           |                                                         |
|             | principal_id                 | principal_id (object_id) of system assigned identity    |
|             | node_resource_group          | auto-generated RG containing resources for this AKS     |
|             | oms_agent_uai                | object_id of oms agent identity                         |
|             | agent_pool_uai               | object_id of kubelet identity                           |
|             | keyvault_secret_provider_uai | object_id of key vault secrets provider secret identity |
|             | fqdn                         | FQDN of the Azure Kubernetes Managed Cluster            |
|             | private_fqdn                 | FQDN for the AKS when private link has been enabled     |
|             | oidc_issuer_url              | OIDC issuer URL associated with the cluster             |


## Example usage of outputs
In the example below, outputted _id_ of the deployed Kubernetes Cluster module is used as a value for the _scope_ variable in Role Assignment resource.
```
module "aks" {
    source = "git@github.com:Seyfor-CSC/mit.kubernetes-cluster.git?ref=v1.0.0"
    config = [
        {
            name                = "SEY-TERRAFORM-NE-AKS01"
            location            = "northeurope"
            resource_group_name = "SEY-TERRAFORM-NE-RG01"
            dns_prefix          = "SEY-TERRAFORM-NE-AKS01"

            default_node_pool {
                name    = "systemnp"
                vm_size = "Standard_D2_v2"
            }
        }
    ]
}

data "azurerm_client_config" "azurerm_client_config" {
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                = module.aks.outputs.sey-terraform-ne-aks01.id # This is how to use output values
    role_definition_name = "Contributor"
    principal_id         = data.azurerm_client_config.azurerm_client_config.object_id
}
```

&nbsp;

# Module Features
## Monitoring tags in `ignore_changes` lifecycle block
We reserve the right to include tags dedicated to our product Advanced Monitoring in the `ignore_changes` lifecycle block. This is to prevent the module from deleting those tags. The tags we ignore are: `tags["Platform"]`, `tags["MonitoringTier"]`.

&nbsp;

# Known Issues
We currently log no issues in this module.