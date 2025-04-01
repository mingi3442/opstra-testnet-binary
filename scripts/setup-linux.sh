#!/bin/bash
# setup-linux.sh - 리눅스 환경에서 opstrad 설치를 위한 스크립트

# 스크립트 실행 경로 확인
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> opstrad 리눅스 설치 스크립트 시작"

# 바이너리 파일 복사
echo "==> 바이너리 파일 복사 중..."
sudo cp "$PARENT_DIR/bin/opstrad-linux-amd64" /usr/local/bin/opstrad
sudo chmod +x /usr/local/bin/opstrad

# 설정 디렉토리 생성
echo "==> 설정 디렉토리 생성 중..."
mkdir -p ~/.opstrad/config

# 기본 설정 파일만 복사 (validator 키는 복사하지 않음)
echo "==> 설정 파일 복사 중..."
cp "$PARENT_DIR/config/app.toml" ~/.opstrad/config/
cp "$PARENT_DIR/config/config.toml" ~/.opstrad/config/
cp "$PARENT_DIR/config/genesis.json" ~/.opstrad/config/

echo "==> opstrad가 성공적으로 설치되었습니다."
echo "==> 주의: 각 노드마다 고유한 validator 키를 생성해야 합니다."
echo "==> 초기화를 위해 다음 명령어를 실행하세요: ./scripts/init.sh"