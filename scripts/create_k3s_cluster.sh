#!/bin/bash

source variaveis_env 

echo "Cria o cluster "${K3D_CLUSTER}"  com "${MASTERS}" control planes e  "${WORKERS}" worker nodes"
sleep 1 
/usr/local/bin/k3d cluster create "${K3D_CLUSTER}" --servers "${MASTERS}" --agents "${WORKERS}"

echo "Checando o cluster criado"
/usr/local/bin/k3d cluster list"
