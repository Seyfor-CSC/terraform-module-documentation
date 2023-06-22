# Important information
All modules are currently tested on terraform version 1.4.5 and azurerm provider version 3.51.0.

Our modules are designed to save you time and effort by providing a consistent approach to deploying resources in Azure. Hardcoding resource ids required in child resources is in the past as it is now done automatically for you inside the module. For example, if you want to deploy a virtual machine with a network interface, you don't need to specify the network interface id in the virtual machine resource. You only need to configure the network interface and the module will take care of the rest.

The same goes for the resource group and location variables. You don't need to specify them in every resource. Just do it once in the parent resource and the child resource will automatically inherit it. The resource group inheritance feature can be overridden if needed by setting the resource_group_name variable to a different value. Location inheritance can currently be overriden only in the private endpoint child module.

By default, { ManagedBy = "Terraform" } tag is added to every resource deployed using our modules.

&nbsp;

# List of all available modules
| Name                                                                 | Latest Version |
| -------------------------------------------------------------------- | -------------- |
| [App Service](./app-service/readme.md)                               | 1.0.0          |
| [Automation Account](./automation-account/readme.md)                 | 1.2.1          |
| [Automation Module](./automation-module/readme.md)                   | 1.0.0          |
| [Availability Set](./availability-set/readme.md)                     | 1.0.0          |
| [Backup Vault](./backup-vault/readme.md)                             | 1.1.3          |
| [Bastion Host](./bastion-host/readme.md)                             | 1.1.0          |
| [Cognitive Account](./cognitive-account/readme.md)                   | 1.0.0          |
| [Container Instance](./container-instance/readme.md)                 | 1.1.2          |
| [Container Registry](./container-registry/readme.md)                 | 1.1.2          |
| [Data Collection Rule](./data-collection-rule/readme.md)             | 1.0.2          |
| [Data Factory](./data-factory/readme.md)                             | 1.1.3          |
| [Event Hub](./event-hub/readme.md)                                   | 1.2.3          |
| [Key Vault](./key-vault/readme.md)                                   | 1.2.1          |
| [Kubernetes Cluster](./kubernetes-cluster/readme.md)                 | 1.1.3          |
| [Linux Virtual Machine](./linux-virtual-machine/readme.md)           | 1.1.5          |
| [Load Balancer](./load-balancer/readme.md)                           | 1.1.2          |
| [Log Analytics Workspace](./log-analytics-workspace/readme.md)       | 1.1.0          |
| [Logic App Standard](./logic-app-standard/readme.md)                 | 1.0.0          |
| [Logic App Workflow](./logic-app-workflow/readme.md)                 | 1.0.0          |
| [Monitor Action Group](./monitor-action-group/readme.md)             | 1.0.0          |
| [Monitor Alert](./monitor-alert/readme.md)                           | 1.0.1          |
| [MSSQL Database](./mssql-database/readme.md)                         | 1.1.3          |
| [MSSQL Managed Instance](./mssql-managed-instance/readme.md)         | 1.0.1          |
| [Network Security Group](./network-security-group/readme.md)         | 1.1.2          |
| [Network Watcher](./network-watcher/readme.md)                       | 1.1.0          |
| [Policy Assignment](./policy-assignment/readme.md)                   | 1.1.1          |
| [Policy Set Definition](./policy-set-definition/readme.md)           | 1.1.0          |
| [PostgreSQL Flexible Server](./postgresql-flexible-server/readme.md) | 1.0.2          |
| [Private DNS Zone](./private-dns-zone/readme.md)                     | 1.1.1          |
| [Private Endpoint](./private-endpoint/readme.md)                     | 1.0.0          |
| [Public IP Address](./public-ip-address/readme.md)                   | 1.1.0          |
| [Public IP Prefix](./public-ip-prefix/readme.md)                     | 1.1.0          |
| [Recovery Services Vault](./recovery-services-vault/readme.md)       | 1.2.5          |
| [Resource Group](./resource-group/readme.md)                         | 1.1.0          |
| [Role Assignment](./role-assignment/readme.md)                       | 1.1.1          |
| [Role Definition](./role-definition/readme.md)                       | 1.1.1          |
| [Route Table](./route-table/readme.md)                               | 1.1.0          |
| [Shared Image Gallery](./shared-image-gallery/readme.md)             | 1.0.0          |
| [Storage Account](./storage-account/readme.md)                       | 1.2.4          |
| [Storage Sync](./storage-sync/readme.md)                             | 1.1.1          |
| [User Assigned Identity](./user-assigned-identity/readme.md)         | 1.0.0          |
| [Virtual Network](./virtual-network/readme.md)                       | 1.1.4          |
| [Virtual Network Peering](./virtual-network-peering/readme.md)       | 1.1.1          |
| [Windows Virtual Machine](./windows-virtual-machine/readme.md)       | 1.1.7          |