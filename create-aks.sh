#!/bin/bash

export AKS_RESOURCE_GROUP=Test
export AKS_LOCATION=japaneast
export AKS_GATEWAY=app-gateway
export CLUSTER_NAME=app-cluster

az aks create \
    --resource-group ${AKS_RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --load-balancer-sku standard \
    --enable-private-cluster \
    --generate-ssh-keys \
    --enable-addons ingress-appgw \
    --appgw-name ${AKS_GATEWAY} \
    --network-plugin azure \
    --vnet-subnet-id '/subscriptions/56d91c85-cf61-42ee-82df-68714c92ab74/resourceGroups/Infra/providers/Microsoft.Network/virtualNetworks/SDZVNet/subnets/AUO-ABS000_AKS' \
    --appgw-subnet-id '/subscriptions/56d91c85-cf61-42ee-82df-68714c92ab74/resourceGroups/Infra/providers/Microsoft.Network/virtualNetworks/SDZVNet/Subnets/AUO-ABS000_AppGw' \
    --node-vm-size Standard_DS3_v2 \
    --node-count 3