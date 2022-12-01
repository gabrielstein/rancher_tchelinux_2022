#! /bin/bash

echo "Executando o container do Rancher" 
sleep 1
sudo docker run  --name rancher -d --restart=unless-stopped -p 80:80 -p 443:443  --privileged  rancher/rancher:latest

echo "Esperando o container iniciar e Obtendo a senha do bootstrap para o primeiro login - Cole ela no primeiro login e configure a sua senha"
sleep 10
sudo docker logs rancher  2>&1 | grep "Bootstrap Password:"

echo "Acesse no Browser: https://`hostname -f`"



