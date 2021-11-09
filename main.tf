terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  count = var.instance_count
  image = docker_image.nginx.latest
  name  = "ngnix_${count.index + 1}"
  ports {

    internal = 80 
    external = (var.external_port + (count.index +1))

  }


}

