# Important information
* All modules are currently tested on terraform version 1.5.4 and azurerm provider version 3.67.0.

* Our modules are designed to save you time and effort by providing a consistent approach to deploying resources in Azure. Hardcoding resource ids required in child resources is in the past as it is now done automatically for you inside the module. For example, if you want to deploy a virtual machine with a network interface, you don't need to specify the network interface id in the virtual machine resource. You only need to configure the network interface and the module will take care of the rest.

* The same goes for the resource group and location variables. You don't need to specify them in every resource. Just do it once in the parent resource and the child resource will automatically inherit it. The resource group inheritance feature can be overridden if needed by setting the resource_group_name variable to a different value. Location inheritance can currently be overriden only in the private endpoint child module.

* Few modules due to their complexity don't support all available variables. If you require any of these varibales, they can be added on demand.

* By default, { ManagedBy = "Terraform" } tag is added to every resource deployed using our modules.

## List of all available modules


| Name | Latest Version |
| ---- | -------------- |
| [app service](./app-service/README.md) | v1.2.0 |
| [automation account](./automation-account/README.md) | v1.5.0 |
| [automation module](./automation-module/README.md) | v1.2.0 |
| [availability set](./availability-set/README.md) | v1.2.0 |
| [backup vault](./backup-vault/README.md) | v1.3.0 |
| [bastion host](./bastion-host/README.md) | v1.3.0 |
| [cognitive account](./cognitive-account/README.md) | v1.1.0 |
| [container instance](./container-instance/README.md) | v1.3.0 |
| [container registry](./container-registry/README.md) | v1.3.0 |
| [data collection rule](./data-collection-rule/README.md) | v1.2.0 |
| [data factory](./data-factory/README.md) | v1.2.0 |
| [event hub](./event-hub/README.md) | v1.4.0 |
| [key vault](./key-vault/README.md) | v1.4.0 |
| [key vault seeding](./key-vault-seeding/README.md) | v1.0.0 |
| [kubernetes cluster](./kubernetes-cluster/README.md) | v1.3.0 |
| [linux virtual machine](./linux-virtual-machine/README.md) | v1.3.1 |
| [load balancer](./load-balancer/README.md) | v1.2.0 |
| [log analytics workspace](./log-analytics-workspace/README.md) | v1.3.0 |
| [logic app integration account](./logic-app-integration-account/README.md) | v1.1.0 |
| [logic app standard](./logic-app-standard/README.md) | v1.2.0 |
| [logic app workflow](./logic-app-workflow/README.md) | v1.3.0 |
| [monitor action group](./monitor-action-group/README.md) | v1.2.0 |
| [monitor alert](./monitor-alert/README.md) | v1.2.0 |
| [mssql database](./mssql-database/README.md) | v1.4.0 |
| [mssql managed instance](./mssql-managed-instance/README.md) | v1.2.0 |
| [network security group](./network-security-group/README.md) | v1.3.0 |
| [network watcher](./network-watcher/README.md) | v1.3.0 |
| [policy assignment](./policy-assignment/README.md) | v1.3.0 |
| [policy set definition](./policy-set-definition/README.md) | v1.3.0 |
| [postgresql flexible server](./postgresql-flexible-server/README.md) | v1.2.0 |
| [private dns resolver](./private-dns-resolver/README.md) | v1.2.0 |
| [private dns zone](./private-dns-zone/README.md) | v1.3.0 |
| [private endpoint](./private-endpoint/README.md) | v1.2.0 |
| [public ip address](./public-ip-address/README.md) | v1.3.0 |
| [public ip prefix](./public-ip-prefix/README.md) | v1.3.0 |
| [purview account](./purview-account/README.md) | v1.1.0 |
| [recovery services vault](./recovery-services-vault/README.md) | v1.5.0 |
| [resource group](./resource-group/README.md) | v1.3.0 |
| [role assignment](./role-assignment/README.md) | v1.3.0 |
| [role definition](./role-definition/README.md) | v1.3.0 |
| [route table](./route-table/README.md) | v1.3.0 |
| [shared image gallery](./shared-image-gallery/README.md) | v1.2.0 |
| [storage account](./storage-account/README.md) | v1.5.0 |
| [storage sync](./storage-sync/README.md) | v1.3.0 |
| [user assigned identity](./user-assigned-identity/README.md) | v1.2.0 |
| [virtual machine scale set](./virtual-machine-scale-set/README.md) | v1.0.0 |
| [virtual network](./virtual-network/README.md) | v1.3.0 |
| [virtual network peering](./virtual-network-peering/README.md) | v1.3.0 |
| [windows virtual machine](./windows-virtual-machine/README.md) | v1.3.1 |
