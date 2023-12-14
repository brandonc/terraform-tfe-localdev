provider "tfe" {
  // Config set by .envrc
}

resource "tfe_organization" "bcroft" {
  name  = "bcroft"
  email = "bcroft@hashicorp.com"
}

resource "tfe_organization_default_settings" "bcroft" {
  organization           = tfe_organization.bcroft.name
  default_execution_mode = "remote"
}

resource "tfe_registry_gpg_key" "bcroft" {
  ascii_armor  = file("assets/bcroft@hashicorp.com.pgp")
  organization = tfe_organization.bcroft.name
}

// A workspace to execute runs within an agent pool for local development
module "agent_pool_workspace" {
  source       = "./modules/agent_pool_workspace"
  name         = "example-agent-execution"
  organization = tfe_organization.bcroft.name
}

output "gpg_key_id" {
  value = tfe_registry_gpg_key.bcroft.id
}

output "agent_token" {
  value     = module.agent_pool_workspace.token
  sensitive = true
}
