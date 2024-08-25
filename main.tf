terraform {
  required_providers {
    netlify = {
      source  = "netlify/netlify"
    }
  }
}

provider "netlify" {
  token = var.netlify_token
}

data "netlify_site" "main" {
  name = "terraform-simple-test"
  team_slug = var.netlify_team_slug
}

variable "netlify_token" {
  type        = string
  description = "Netlify personal access token"
}

variable "netlify_team_slug" {
  type        = string
  description = "Netlify team slug"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository path (e.g., 'username/repo')"
}

output "netlify_site_url" {
  description = "URL of the deployed Netlify site"
  value       = data.netlify_site.main
}