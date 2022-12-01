#!/bin/bash

echo "Instalando os pacotes necessarios para a demonstração(zypper)"
zypper --non-interactive  install -y docker curl wget sudo

echo "Instalando o kubectl para interagir com o cluster"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "Fazendo o download do k3d e o deployment"
sleep 1
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo "Iniciando o docker-daemon"
sleep 1
systemctl start docker

source variaveis_env 

echo "Cria o cluster "${K3D_CLUSTER}"  com "${MASTERS}" control planes e  "${WORKERS}" worker nodes"
sleep 1 
/usr/local/bin/k3d cluster create "${K3D_CLUSTER}" --servers "${MASTERS}" --agents "${WORKERS}"

echo "Executando o container do Rancher" 
sleep 3
docker run  --name "${RANCHER_CONTAINER}"  -d --restart=unless-stopped -p 80:80 -p 443:443  --privileged  rancher/rancher:latest

echo "Esperando o container iniciar e Obtendo a senha do bootstrap para o primeiro login - Cole ela no primeiro login e configure a sua senha"
sleep 10
docker logs "${RANCHER_CONTAINER}"  2>&1 | grep "Bootstrap Password:"

echo "Acesse no Browser: https://`hostname -f`"
