echo "--------------------------------------------------"
echo "> Instalando Y configurando Docker"
echo "--------------------------------------------------"
## DESINSTALAR CUALQUIER DEPENDENCIA
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update -qq
sudo apt-get install -y -qq ca-certificates curl openjdk-17-jdk git
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc


# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -qq

# INSTALAMOS DOCKER
sudo apt-get -y -qq install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "--------------------------------------------------"
echo "> Probando Docker"
echo "--------------------------------------------------"

sudo docker run hello-world

# PERMISOS PARA EJECUTAR DOCKER SIN SUPER USUARIO
sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

# CONFIGURAR DOCKER PARA INICIAR CON EL SISTEMA
sudo systemctl enable docker.service
sudo systemctl enable containerd.service