#!/bin/bash

export RESOURCE_GROUP=Infra
export AKS_LOCATION=japaneast
export NAME=sdzkibana

az webapp config access-restriction add \
    --resource-group ${RESOURCE_GROUP} \
    --name ${NAME} \
    --rule-name 'AUO_SDZ_CHT' \
    --action Allow \
    --ip-address '60.248.185.177' \
    --priority 100

az webapp config access-restriction add \
    --resource-group ${RESOURCE_GROUP} \
    --name ${NAME} \
    --rule-name 'AUO_SDZ_FET' \
    --action Allow \
    --ip-address '122.146.68.5' \
    --priority 101

az resource update --resource-group ResourceGroup --name AppName --resource-type "Microsoft.Web/sites" \
    --set properties.siteConfig.ipSecurityRestrictionsDefaultAction=Allow