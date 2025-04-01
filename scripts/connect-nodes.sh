#!/bin/bash
# connect-nodes.sh - 다른 노드와 연결하기 위한 스크립트

# 사용법 표시
function show_usage {
    echo "사용법: $0 <노드ID>@<IP주소>:<포트>"
    echo "예: $0 8cc98c8b47c8943de4126e62f137806959c381ec@192.168.1.100:26656"
    exit 1
}

# 인자 확인
if [ $# -lt 1 ]; then
    show_usage
fi

PEER="$1"
CONFIG_FILE="$HOME/.opstrad/config/config.toml"

# 노드 ID 확인
MY_NODE_ID=$(opstrad tendermint show-node-id)
echo "내 노드 ID: $MY_NODE_ID"

# config.toml 파일에서 persistent_peers 설정 업데이트
if grep -q "^persistent_peers =" "$CONFIG_FILE"; then
    # 이미 설정이 있으면 업데이트
    CURRENT_PEERS=$(grep "^persistent_peers =" "$CONFIG_FILE" | cut -d'"' -f2)
    
    if [[ "$CURRENT_PEERS" == *"$PEER"* ]]; then
        echo "이미 $PEER 노드가 연결되어 있습니다."
    else
        if [ -z "$CURRENT_PEERS" ]; then
            NEW_PEERS="$PEER"
        else
            NEW_PEERS="$CURRENT_PEERS,$PEER"
        fi
        
        sed -i "s/^persistent_peers = \".*\"/persistent_peers = \"$NEW_PEERS\"/" "$CONFIG_FILE"
        echo "노드 $PEER가 연결 목록에 추가되었습니다."
    fi
else
    echo "persistent_peers 설정을 찾을 수 없습니다. 설정 파일을 확인하세요."
    exit 1
fi

echo "설정이 완료되었습니다. 노드를 재시작하세요:"
echo "opstrad start"