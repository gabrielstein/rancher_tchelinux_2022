# rancher_tchelinux_2022
Slides e comandos da apresentacao do Tchelinux

Olá, eu estarei atualiozando esse repositório nas próximas horas.

### Disclaimer: Todas as instruções aqui são para criar um playground e aprender um pouco das ferramentas da apresentação!!



Primeiramente vou colocar alguns links aqui que foram usados para a apresentação:


## O que você irá precisar na máquina(pré-requisitos):

- docker
- curl
- wget
- sudo
- kubectl
- Acesso ao superusuário via sudo


Isso pode ser instalado na maior parte das distros com:

'<gerenciador de pacotes>' install -y docker curl sudo wget sudo kubectl

Se o kubectl não estiver nos repositórios da sua distro:

Instruções: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/


## Para criar clusters de teste numa máquina local|teste
- K3d: https://k3d.io/v5.4.6/
- Multi-cluster com o K3d: https://docs.rancherdesktop.io/how-to-guides/create-multi-node-cluster/

## Tecnologia que o K3d usa para criar os clusters
- K3s(o lightweight K8s que o K3d cria clusters): https://k3s.io/ 

## Instalar o Rancher em um único Host com o docker
- Rancher: https://docs.ranchermanager.rancher.io/v2.5/pages-for-subheaders/rancher-on-a-single-node-with-docker


## FAQ

- Funciona com podman? R: Não testei, usei docker
- Qual a distro que usou para fazer a apresentação? R: SUSE Linux Enterprise 15 SP4 / Mas deve funcionar em qualquer distro com docker 
- Dá para usar esses clusters em produção? R: Não, de jeito nenhum, é para testes apenas
- Você vai criar uns scripts para poder fazer o bootstrap desses clusters e SUSE Rancher? 
R: Sim, eu não tenho como fazer eles 'distro-agnóstica' - por isso o script vai funcionar se você tiver os pré-requisitos instalados primeiro. 


## Instalação manual


# K3d

1. Baixe o script para instalar o K3d e rode o script

`
 wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
`

2. Crie os clusters com o K3d (Agents: Worker nodes // Servers: Masters / Control Plane) 

`
k3d cluster create two-node-cluster --agents 2 # Cria o cluster com 2 worker nodes
k3d cluster create three-node-cluster --agents 3 # Cria o cluster com 3 worker nodes
k3d cluster create tchelinux --servers 3 --agents 2 # Cria o cluster com 3 masters e 2 worker nodes
`


# SUSE Rancher ( com certificados self-signed )

1. Rodar o container do Rancher

`
docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  --privileged \
  rancher/rancher:latest
`

2. Acesse no Browser: https://localhost

3. Faça um grep nos logs do container para descobrir a senha do bootstrap

4. Cole a senha do bootstrap no campo da senha no Browser e configure uma senha ==>>>(não se esqueça de selecionar a '2a' opção de criar uma senha e não aceitar a que foi gerada automaticamente) <<<==


