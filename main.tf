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

resource "null_resource" "deploy_site" {
  provisioner "local-exec" {
    command = <<EOT
      netlify sites:create --name terraform-simple-site-${terraform.workspace} --auth ${var.netlify_token} --git ${var.github_repo} --team ${var.netlify_team_slug}
    EOT
    environment = {
      NETLIFY_AUTH_TOKEN = var.netlify_token
    }
  }
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
  value       = "https://terraform-simple-site-${terraform.workspace}.netlify.app"
}
