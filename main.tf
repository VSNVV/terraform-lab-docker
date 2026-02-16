module "bastion" {
    source = "./modules/container"

    container_name = "bastion"
    image_name = "ubuntu:latest"
    user = "ubuntu"
    tty = true
    must_run = true
    networks_advanced = [
        {
            name = docker_network.network.id
            aliases = ["bastion"]
        }
    ]
    mounts = [
        {
            source = "${local.common.terraform_lab_path}/scripts/bastion.sh" # Give permissions using chmod
            target = "/init.sh"
            type = "bind"
        }
    ]
}

module "ec2" {
    source = "./modules/container"

    container_name = "ec2"
    image_name = "ubuntu:latest"
    user = "ubuntu"
    tty = true
    must_run = true
    networks_advanced = [
        {
            name = docker_network.network.id
            aliases = ["ec2"]
        }
    ]
    mounts = [
        {
            source = "${local.common.ssh_folder_path}/id_rsa.pub"
            target = "/home/root/.ssh/authorized_keys"
            type = "bind"
        }
    ]
}

