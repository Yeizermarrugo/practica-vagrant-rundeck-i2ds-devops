#!/bin/bash
# Actualizar lista de paquetes e instalar dependencias
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk wget

# Configurar el repositorio y la clave de Rundeck
curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/deb-setup.sh 2> /dev/null | sudo bash -s rundeck

# Update apt cache and install
sudo apt-get install rundeck


# Iniciar y habilitar Rundeck
sudo systemctl start rundeckd
sudo systemctl enable rundeckd

# Instalar ngrok
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok -y

# Configurar ngrok con el token de autenticación
ngrok config add-authtoken 2h7k5rhbxBBzUvQtXankpUtJAee_4G6Uty9gfkQt7m83iedgT

# Instalar vagrant-share
vagrant plugin install vagrant-share


# Habilitar ngrok en el puerto 4440
ngrok http 4440 &

# Información de acceso
echo "Rundeck instalado y disponible en http://192.168.124.100:4440 con credenciales admin/admin"
