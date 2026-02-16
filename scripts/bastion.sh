#!/bin/bash

# Evitar cualquier prompt interactivo
export DEBIAN_FRONTEND=noninteractive

# Esperar que otros servicios arranquen
sleep 10

# Cambiar contraseña root
echo 'root:root' | chpasswd && echo "Root password changed."

# Actualizar e instalar paquetes necesarios
apt update
apt-add-repository --yes --update ppa:ansible/ansible
apt install -y openssh-server sshpass vim pipx iputils-ping net-tools jq

# Installing ansible via pipx
pipx install --include-deps ansible
pipx install ansible-core
pipx upgrade --include-injected ansible
pipx inject ansible argcomplete
pipx inject --include-apps ansible argcomplete
pipx inject ansible pyvmomi
pipx inject ansible requests

# Preparar clave SSH
mkdir -p /root/.ssh
ssh-keygen -t rsa -f /root/.ssh/id_rsa -C "" -N "" -q

# Configurar sshd para permitir login como root
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Copiar claves públicas a otros servidores (sin pedir confirmación)
sshpass -p 'root' ssh-copy-id -i /root/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@oracle
sshpass -p 'root' ssh-copy-id -i /root/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@nginx-1
sshpass -p 'root' ssh-copy-id -i /root/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@db1
sshpass -p 'root' ssh-copy-id -i /root/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@db2
sshpass -p 'root' ssh-copy-id -i /root/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@wordpress
sshpass -p 'root' ssh-copy-id -i /root/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@redhat

# Iniciar servicio SSH
service ssh start

# Agregar al PATH el entorno virtual de pipx
export PATH=$PATH:/root/.local/share/pipx/venvs/ansible/bin
echo "VENV added to PATH"

echo "Bastion Server Ready"

# Mantener el contenedor corriendo
sleep infinity
