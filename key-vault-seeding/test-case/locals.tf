locals {
  location = "northeurope"

  naming = {
    rg = "SEY-TERRAFORM-RG01"
    kv = "SEY-TERRAFORM-KV01"
  }

  seeding = {
    secret = [
      {
        name         = "FirstSecret" # Generates random password 12 characters long
        key_vault_id = azurerm_key_vault.kv.id
      },
      {
        name         = "SecondSecret"
        length       = 16 # Generates random password 16 characters long
        key_vault_id = azurerm_key_vault.kv.id
      },
      {
        name         = "ThirdSecret"
        value        = "Password1234" # Sets the secret value to "Password1234"
        key_vault_id = azurerm_key_vault.kv.id
      }
    ]
  }
}
