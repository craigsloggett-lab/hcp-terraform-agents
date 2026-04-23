terraform {
  cloud {
    organization = "craigsloggett-lab"

    workspaces {
      project = "Infrastructure"
      name    = "hcp-terraform-agents"
    }
  }
}
