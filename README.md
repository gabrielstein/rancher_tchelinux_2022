# rancher_tchelinux_2022
Slides e comandos da apresentacao do Tchelinux

Olá, eu estarei atualiozando esse repositório nas próximas horas.

Primeiramente vou colocar alguns links aqui que foram usados para a apresentação:


## O que você irá precisar na máquina(pré-requisitos):

- docker
- curl
- wget
- sudo
- Acesso ao superusuário via sudo

Isso pode ser instalado na maior parte das distros com:

'<gerenciador de pacotes>' install -y docker curl sudo wget sudo 

## Para criar clusters de teste numa máquina local|teste
- K3d: https://k3d.io/v5.4.6/

## Tecnologia que o K3d usa para criar os clusters
- K3s(o lightweight K8s que o K3d cria clusters): https://k3s.io/ 


## FAQ

- Funciona com podman? R: Não testei, usei docker
- Qual a distro que usou para fazer a apresentação? R: SUSE Linux Enterprise 15 SP4 / Mas deve funcionar em qualquer distro com docker 
- Dá para usar esses clusters em produção? R: Não, de jeito nenhum, é para testes apenas
- Você vai criar uns scripts para poder fazer o bootstrap desses clusters e SUSE Rancher? 
R: Sim, eu não tenho como fazer eles 'distro-agnóstica' - por isso o script vai funcionar se você tiver os pré-requisitos instalados primeiro. 


