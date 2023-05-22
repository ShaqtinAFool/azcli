#!/bin/bash

export VNET_RESOURCE_ID="/subscriptions/56d91c85-cf61-42ee-82df-68714c92ab74/resourceGroups/Infra/providers/Microsoft.Network/virtualNetworks/SDZVNet"
export RESOURCE_GROUP=Test
export AKS_LOCATION=japaneast
export APP_GATEWAY=tonylee-asc
export AKS_CLUSTER_NAME=tonylee-asc

# AKS (CNI) + AppGw
az aks create \
    --resource-group ${RESOURCE_GROUP} \
    --name ${AKS_CLUSTER_NAME} \
    --generate-ssh-keys \
    --enable-private-cluster \
    --network-plugin azure \
    --vnet-subnet-id "${VNET_RESOURCE_ID}/subnets/AUO-ABS000_AKS" \
    --enable-addons ingress-appgw \
    --appgw-name ${APP_GATEWAY} \
    --appgw-subnet-id "${VNET_RESOURCE_ID}/Subnets/AUO-ABS000_AppGw" \
    --load-balancer-sku standard \
    --node-vm-size Standard_DS3_v2 \
    --node-count 3

# AKS (kubernet) + AppGw
az aks create \
    --resource-group ${RESOURCE_GROUP} \
    --name ${AKS_CLUSTER_NAME} \
    --generate-ssh-keys \
    --enable-private-cluster \
    --network-plugin kubenet \
    --enable-addons ingress-appgw \
    --appgw-name ${APP_GATEWAY} \
    --appgw-subnet-id "${VNET_RESOURCE_ID}/Subnets/AUO-ABS000_AppGw" \
    --load-balancer-sku standard \
    --node-vm-size Standard_DS3_v2 \
    --node-count 3

# Connection Test
az aks get-credentials \
    --resource-group ${RESOURCE_GROUP} \
    --name ${AKS_CLUSTER_NAME}
kubectl get nodes