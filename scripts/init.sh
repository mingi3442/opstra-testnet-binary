#!/bin/bash
# init.sh - 노드 초기화 스크립트


if [ -f ~/.opstrad/config/priv_validator_key.json ]; then
    echo "==> 이미 초기화된 노드입니다. 새로 초기화하려면 먼저 ~/.opstrad 디렉토리를 삭제하세요."
    exit 1
fi


echo "==> 노드 초기화 중..."
opstrad init $(hostname) --chain-id opstra-1

# 계정 생성
echo "==> 계정 생성 중..."
opstrad keys add validator --keyring-backend test
opstrad keys add user --keyring-backend test

# 토큰 할당
echo "==> 토큰 할당 중..."
opstrad genesis add-genesis-account validator 10000000opstra --keyring-backend test
opstrad genesis add-genesis-account user 1000opstra --keyring-backend test

# validator 생성
echo "==> Validator 생성 중..."
opstrad genesis gentx validator 1000000opstra --chain-id opstra-1 --keyring-backend test

# gentx 수집
echo "==> Gentx 수집 중..."
opstrad genesis collect-gentxs

echo "==> 초기화 완료. 노드를 시작하려면 'opstrad start' 명령어를 실행하세요."