# rancher_tchelinux_2022
Comandos e instruções para reproduzir os testes da apresentação.

# Disclaimer: Todas as instruções aqui são para criar um playground e aprender um pouco das ferramentas da apresentação!!

## PRs são bem-vindas!


Primeiramente vou colocar alguns links aqui que foram usados para a apresentação:


### O que você irá precisar na máquina(pré-requisitos):

- docker
- curl
- wget
- sudo
- kubectl

Acesso: para teste é recommendado usar o root numa máquina de testes. Eu estou ainda trabalhando em scripts sem precisar do superusuário.
Máquina: para testes eu estou usando um i5 com 16GB de RAM. Acho que funciona tranquilo com 8GB de RAM também, mas não testei.


Isso pode ser instalado na maior parte das distros com:

`'<gerenciador de pacotes>' install -y docker curl sudo wget sudo kubectl`

Se o kubectl não estiver nos repositórios da sua distro: [Instruções](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)


#### Para criar clusters de teste numa máquina local|teste
- [K3d] (https://k3d.io/v5.4.6/)
- [Multi-cluster com o K3d](https://docs.rancherdesktop.io/how-to-guides/create-multi-node-cluster/)

#### Tecnologia que o K3d usa para criar os clusters
- [K3s(o lightweight K8s que o K3d cria clusters)](https://k3s.io/) 

#### Instalar o Rancher em um único Host com o docker
- [Rancher](https://docs.ranchermanager.rancher.io/v2.5/pages-for-subheaders/rancher-on-a-single-node-with-docker)


### Comandos básicos para interagir com o k3d


#### Lista os clusters do k3d 

```
k3d cluster list
```

#### Apaga um cluster 

```
k3d cluster delete <nome do cluster>
```

#### Cria um cluster com o k3d (--servers == masters e --agents == workers - Não precisa ter masters e clientes juntos)

```
k3d cluster create <meu cluster> --servers 3 --agents 3
```


## FAQ

- Funciona com podman? R: Não testei, usei docker
- Qual a distro que usou para fazer a apresentação? R: SUSE Linux Enterprise 15 SP4 / Mas deve funcionar em qualquer distro com docker 
- Dá para usar esses clusters em produção? R: Não, de jeito nenhum, é para testes apenas
- Você vai criar uns scripts para poder fazer o bootstrap desses clusters e SUSE Rancher? 
R: Sim, eu não tenho como fazer eles 'distro-agnóstica' - por isso o script vai funcionar se você tiver os pré-requisitos instalados primeiro. 
- Quantas instâncias do Rancher eu preciso para esse teste? R: Apenas uma. Como o Rancher irá fazer o gerenciamento de vários clusters não é necessário implementar o container diversas vezes.


## Scripts

#Todos os scripts estao dento do diretório scripts

- deploy_tumbleweed.sh: Supondo que vocês está rodando um host com openSUSE Tumbleweed, esse script executa todos os passos da intalação manual(precisa de sudo).
- fast_deploy.sh:  Script para rodar quando todas as dependencias foram satisfeitas. Configure o cluster usando as variaveis de ambiente no arquivo `variaveis_env`
- start_rancher.sh:  Script para rodar o container do Rancher apenas(supondo que já existe um cluster rodando para ser importado).
- create_k3s_cluster.sh:  Script para criar um cluster do k3s com o k3d somente, sem Rancher. 


## Instalação manual


### K3d

1. Baixe o script para instalar o K3d e rode o script

`
 wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
`

2. Crie os clusters com o K3d (Agents: Worker nodes // Servers: Masters / Control Plane) 

````
k3d cluster create two-node-cluster --agents 2 # Cria o cluster com 2 worker nodes
k3d cluster create three-node-cluster --agents 3 # Cria o cluster com 3 worker nodes
k3d cluster create tchelinux --servers 3 --agents 2 # Cria o cluster com 3 masters e 2 worker nodes
```


### SUSE Rancher ( com certificados self-signed )

1. Rodar o container do Rancher

```
docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  --privileged \
  rancher/rancher:latest
```

2. Acesse no Browser: https://`hostname -f`

3. Faça um grep nos logs do container para descobrir a senha do bootstrap

4. Cole a senha do bootstrap no campo da senha no Browser e configure uma senha ==>>>(não se esqueça de selecionar a '2a' opção de criar uma senha e não aceitar a que foi gerada automaticamente) <<<==


