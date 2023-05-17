#!/bin/bash

export VNET_RESOURCE_ID="/subscriptions/56d91c85-cf61-42ee-82df-68714c92ab74/resourceGroups/Infra/providers/Microsoft.Network/virtualNetworks/SDZVNet"
export AKS_RESOURCE_GROUP=Test
export AKS_LOCATION=japaneast
export AKS_GATEWAY=tonylee
export CLUSTER_NAME=tonylee

# AKS (CNI) + AppGw
az aks create \
    --resource-group ${AKS_RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --generate-ssh-keys \
    --enable-addons ingress-appgw \
    --enable-private-cluster \
    --dns-service-ip 10.0.0.10 \
    --service-cidr 10.0.0.0/16 \
    --docker-bridge-address 172.17.0.1/16 \
    --network-plugin azure \
    --vnet-subnet-id "${VNET_RESOURCE_ID}/subnets/AUO-ABS000_AKS" \
    --appgw-name ${AKS_GATEWAY} \
    --appgw-subnet-id "${VNET_RESOURCE_ID}/Subnets/AUO-ABS000_AppGw" \
    --load-balancer-sku standard \
    --node-vm-size Standard_DS3_v2 \
    --node-count 3

# AKS (kubernet) + AppGw
az aks create \
    --resource-group ${AKS_RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --generate-ssh-keys \
    --enable-addons ingress-appgw \
    --enable-private-cluster \
    --network-plugin kubenet \
    --appgw-name ${AKS_GATEWAY} \
    --appgw-subnet-id "${VNET_RESOURCE_ID}/Subnets/AUO-ABS000_AppGw" \
    --load-balancer-sku standard \
    --node-vm-size Standard_DS3_v2 \
    --node-count 3