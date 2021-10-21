project = "waypoint-nodejs"

app "waypoint-nodejs" {
  labels = {
    "service" = "waypoint-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "loord321/waypoint-nodejs"
        tag   = gitrefpretty()
        local = true
      }
    }
  }

  deploy {
    use "helm" {
      name  = app.name
      chart = "${path.app}/helm"

      // We use a values file so we can set the entrypoint environment
      // variables into a rich YAML structure. This is easier than --set
      values = [
        file(templatefile("${path.app}/values.yaml.tpl")),
      ]

      set {
        name  = "image.repository"
        value = artifact.image
      }

      set {
        name  = "image.tag"
        value = artifact.tag
      }
    }
  }
}
