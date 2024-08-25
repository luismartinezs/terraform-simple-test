terraform {
  required_providers {
    netlify = {
      source  = "netlify/netlify"
      version = "~> 0.5.0"
    }
  }
}

provider "netlify" {
  token = var.netlify_token
}

resource "netlify_site" "main" {
  name = "my-simple-website"

  repo {
    provider    = "github"
    repo_path   = var.github_repote
    branch      = "main"
  }
}

variable "netlify_token" {
  type        = string
  description = "Netlify personal access token"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository path (e.g., 'username/repo')"
}

output "netlify_site_url" {
  description = "URL of the deployed Netlify site"
  value       = netlify_site.main.site_url
}