#!/bin/bash



echo "==> Initialize node..."
opstrad init $(whoami) --chain-id opstra-testnet-1

# Create account
echo "==> Create account..."
opstrad keys add $(whoami) --keyring-backend 
# opstrad keys add user --keyring-backend $(whoami)

# Assign tokens
echo "==> Assign tokens..."
opstrad genesis add-genesis-account $(whoami) 10000000uopstra --keyring-backend 
# opstrad genesis add-genesis-account user 1000uopstra --keyring-backend $(whoami)

# Create validator
echo "==> Create validator..."
opstrad genesis gentx $(whoami) 1000000uopstra --chain-id opstra-testnet-1 --keyring-backend 

# Collect gentxs
echo "==> Collect gentxs..."
opstrad genesis collect-gentxs

echo "==> Initialize completed. To start the node, run 'opstrad start' command."