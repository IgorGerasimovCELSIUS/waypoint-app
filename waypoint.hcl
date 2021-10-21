project = "waypoint-nodejs"

runner {
  enable = true

  data_source "git" {
        url  = "https://github.com/IgorGerasimovCELSIUS/waypoint-app.git"    
        path = "./"  
        }
      }

app "waypoint-nodejs" {
  labels = {
    "service" = "waypoint-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
#    hook {            
#      when = "before"            
#      command = ["./audit-log.sh", "build starting"]            
#      on_failure = "continue"        
#    }
    registry {
      use "docker" {
        image = "loord321/waypoint-nodejs"
        tag   = gitrefpretty()
#        encoded_auth = filebase64("/Users/igor/Develop/waypoint-app/dockerAuth.json") - example of auth in docker registry 
      }
    }
  }

  deploy {
    use "helm" {
      name  = app.name
      chart = "${path.app}/helm"

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

  release {    
    use "kubernetes" {      
      load_balancer = true      
      port          = 80    
    }  
  }
}
