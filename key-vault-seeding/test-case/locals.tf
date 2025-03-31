locals {
  location = "northeurope"

  naming = {
    rg = "SEY-SEEDING-NE-RG01"
  }

  seeding = {
    secret = [
      {
        name         = "FirstSecret" # Generates random password 12 characters long set to `value`
        key_vault_id = azurerm_key_vault.kv.id
        special      = false
      },
      {
        name         = "SecondSecret"
        length       = 16 # Generates random password 16 characters long set to `value`
        key_vault_id = azurerm_key_vault.kv.id
      },
      {
        name         = "ThirdSecret"
        value        = "Password1234" # Sets the secret `value` to "Password1234"
        key_vault_id = azurerm_key_vault.kv.id
      },
      {
        name             = "FourthSecret"
        value_wo_version = "1" # Generates random password sent to `value_wo`
        key_vault_id     = azurerm_key_vault.kv.id
      }
    ]
  }
}
