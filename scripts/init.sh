#!/bin/bash



echo "==> Initialize node..."
opstrad init $(hostname) --chain-id opstra-testnet-1

# Create account
echo "==> Create account..."
opstrad keys add validator --keyring-backend $(whoami)
opstrad keys add user --keyring-backend $(whoami)

# Assign tokens
echo "==> Assign tokens..."
opstrad genesis add-genesis-account validator 10000000uopstra --keyring-backend $(whoami)
opstrad genesis add-genesis-account user 1000uopstra --keyring-backend $(whoami)

# Create validator
echo "==> Create validator..."
opstrad genesis gentx validator 1000000uopstra --chain-id opstra-testnet-1 --keyring-backend $(whoami)

# Collect gentxs
echo "==> Collect gentxs..."
opstrad genesis collect-gentxs

echo "==> Initialize completed. To start the node, run 'opstrad start' command."