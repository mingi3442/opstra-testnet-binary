#!/bin/bash
# setup-linux.sh - 리눅스 환경에서 opstrad 설치를 위한 스크립트

# 스크립트 실행 경로 확인
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> opstrad Linux installation script started"

# Copy binary file
echo "==> Copying binary file..."
sudo cp "$PARENT_DIR/bin/opstrad-linux-amd64" /usr/local/bin/opstrad
sudo chmod +x /usr/local/bin/opstrad

# Setting directory creation
echo "==> Setting directory creation..."
mkdir -p ~/.opstrad/config

# Default configuration files only (do not copy validator key)
echo "==> Configuration file copying..."
cp "$PARENT_DIR/config/app.toml" ~/.opstrad/config/
cp "$PARENT_DIR/config/config.toml" ~/.opstrad/config/
cp "$PARENT_DIR/config/genesis.json" ~/.opstrad/config/

echo "==> opstrad successfully installed."
echo "==> Note: Each node must have its own unique validator key."
echo "==> To initialize, run: ./scripts/init.sh"