#!/bin/bash

if [ -z $DEX_CONTRACT_DEPLOYMENT_DIR ] ; then
        echo "Please set DEX_CONTRACT_DEPLOYMENT_DIR"

        exit 1
fi

if [ -z $DEX_NETWORK_NAME ] ; then
        echo "Please set DEX_NETWORK_NAME; baobab, cypress"

        exit 1
fi

if [ -z $DEX_GRAPHNODE_ADMIN_URL ] ; then
        echo "Please set DEX_GRAPHNODE_ADMIN_URL."

        exit 1
fi

cp $DEX_CONTRACT_DEPLOYMENT_DIR/networks-DexFactory.json /app/subgraphs/exchange/networks.json
cp $DEX_CONTRACT_DEPLOYMENT_DIR/networks-Farming.json /app/subgraphs/farming/networks.json
cp $DEX_CONTRACT_DEPLOYMENT_DIR/networks-StakingFactory.json /app/subgraphs/staking/networks.json

yarn codegen
yarn build --network $DEX_NETWORK_NAME
yarn create-remote
yarn deploy-remote --network $DEX_NETWORK_NAME