resource "tfe_workspace" "example-agent-execution" {
  name         = var.name
  organization = var.organization
}

resource "tfe_workspace_settings" "example-agent-execution" {
  workspace_id   = tfe_workspace.example-agent-execution.id
  agent_pool_id  = tfe_agent_pool.pool.id
  execution_mode = "agent"
}

resource "tfe_agent_pool" "pool" {
  name         = join("-", [var.name, "pool"])
  organization = var.organization
}

resource "tfe_agent_token" "pool" {
  agent_pool_id = tfe_agent_pool.pool.id
  description   = "An agent token"
}

resource "tfe_agent_pool_allowed_workspaces" "pool" {
  agent_pool_id         = tfe_agent_pool.pool.id
  allowed_workspace_ids = [tfe_workspace.example-agent-execution.id]
}
