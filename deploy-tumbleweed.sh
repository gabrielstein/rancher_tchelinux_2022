
echo "Instalando os pacotes necessarios para a demonstração(zypper)"
sudo zypper --non-interactive  install -y docker curl wget sudo

echo "Instalando o kubectl para interagir com o cluster"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "Fazendo o download do k3d e o deployment"
sleep 1
sudo wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo "Iniciando o docker-daemon"
sleep 1
sudo systemctl start docker

echo "Cria o cluster com 3 control planes and 2 worker nodes"
sleep 1 
sudo  /usr/local/bin/k3d cluster create tchelinux --servers 3 --agents 2 

echo "Executando o container do Rancher" 
sleep 3
sudo docker run  --name rancher -d --restart=unless-stopped -p 80:80 -p 443:443  --privileged  rancher/rancher:latest

echo "Esperando o container iniciar e Obtendo a senha do bootstrap para o primeiro login - Cole ela no primeiro login e configure a sua senha"
sleep 10
sudo docker logs rancher  2>&1 | grep "Bootstrap Password:"

echo "Acesse no Browser: https://`hostname -f`"



