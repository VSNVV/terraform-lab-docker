resource "docker_image" "image" {
    name = var.image_name
}

resource "docker_container" "container" {
    name = var.container_name
    image = docker_image.image.id
    command = var.command
    entrypoint = var.entrypoint
    hostname = var.hostname
    must_run = var.must_run
    tty = var.tty
    working_dir = var.working_dir

    dynamic "volumes" {
        for_each = var.volumes
        content {
            host_path      = volumes.value["host_path"]
            container_path = volumes.value["container_path"]
        }
    }

    dynamic "mounts" {
        for_each = var.mounts
        content {
            source = mounts.value["source"]
            target = mounts.value["target"]
            type = mounts.value["type"]
        }
    }

    dynamic "networks_advanced" {
        for_each = var.networks_advanced
        content {
            name = networks_advanced.value["name"]
            aliases = networks_advanced.value["aliases"]
        }
    }
}