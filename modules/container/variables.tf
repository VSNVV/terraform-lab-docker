variable "image_name" {
    # Required
    description = "Docker image used by container"
    type = string
}

variable "container_name" {
    # Required
    description = "Docker containers name"
    type = string
    
}

variable "command" {
    # Optional
    description = "Docker containers command to use to start the container"
    type = list(string)
    default = [""]
}

variable "entrypoint" {
    # Optional
    description = "The command to use as the Entrypoint for the container. The entrypoint allows you to configure a container to run as an executable"
    type = list(string)
    default = []
}

variable "hostname" {
    # Optional
    description = "Hostname for container"
    type = string
    default = ""
}

variable "must_run" {
    # Optional
    description = "Boolean that says if container keeps running or not"
    type = bool
    default = true
}

variable "volumes" {
    # Optional
    description = "Containers volumes"
    type = list(object({
        host_path      = string
        container_path = string
    }))
    default = []
}

variable "mounts" {
    # Optional
    description = "Containers mounts"
    type = list(object({
        source = string
        target = string
        type = string
    }))
    default = []
}

variable "tty" {
    # Optional
    description = "Boolean for allocating a pseudo-tty (docker run -t)"
    type = bool
    default = false
}

variable "working_dir" {
    # Optional
    description = "The working directory for commands to run it"
    type = string
    default = ""
}

variable "networks_advanced" {
    # Optional
    description = "Network which container has attached"
    type = list(object({
        name = string
        aliases = list(string)
    }))
    default = []
}

variable "user" {
    # Optional
    description = "User in container"
    type = string
    default = "ubuntu"
}
