#!/bin/bash
# init.sh - 노드 초기화 스크립트


echo "==> Initialize node..."
opstrad init $(hostname) --chain-id opstra-testnet-1

# 계정 생성
echo "==> Create account..."
opstrad keys add validator --keyring-backend ${whoami}
opstrad keys add user --keyring-backend ${whoami}

# 토큰 할당
echo "==> Assign tokens..."
opstrad genesis add-genesis-account validator 10000000uopstra --keyring-backend ${whoami}
opstrad genesis add-genesis-account user 1000uopstra --keyring-backend ${whoami}

# validator 생성
echo "==> Create validator..."
opstrad genesis gentx validator 1000000uopstra --chain-id opstra-testnet-1 --keyring-backend ${whoami}

# gentx 수집
echo "==> Collect gentxs..."
opstrad genesis collect-gentxs

echo "==> Initialize completed. To start the node, run 'opstrad start' command."