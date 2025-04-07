# opstra-binary 레포지토리용 Makefile

.PHONY: install clean start stop connect help

# 기본 타겟
all: help

# Install
install:
	@echo "==> Install opstrad..."
	@chmod +x scripts/setup-linux.sh
	@./scripts/setup-linux.sh
	@echo "==> Install completed"

# Initialize
init:
	@echo "==> Initialize node..."
	@chmod +x scripts/init.sh
	@./scripts/init.sh
	@echo "==> Initialize completed. To start the node, run 'opstrad start' command."

# Start
start:
	@echo "==> opstrad 노드 시작 중..."
	@opstrad start
	@echo "==> 노드 시작 완료"

# 노드 정지 (백그라운드로 실행 중인 경우)
stop:
	@echo "==> opstrad 노드 정지 중..."
	@pkill -f opstrad || echo "노드가 실행 중이 아닙니다."
	@echo "==> 노드 정지 완료"

# 다른 노드와 연결
connect:
	@if [ -z "$(NODE)" ]; then \
		echo "사용법: make connect NODE=<노드ID>@<IP주소>:<포트>"; \
		echo "예: make connect NODE=8cc98c8b47c8943de4126e62f137806959c381ec@192.168.1.100:26656"; \
		exit 1; \
	fi
	@echo "==> 노드 $(NODE)와 연결 중..."
	@chmod +x scripts/connect-nodes.sh
	@./scripts/connect-nodes.sh $(NODE)
	@echo "==> 연결 완료"

# 설정 파일 확인
config:
	@echo "==> 설정 파일 확인 중..."
	@ls -la ~/.opstrad/config/
	@echo "==> app.toml 내용:"
	@grep "minimum-gas-prices" ~/.opstrad/config/app.toml
	@echo "==> config.toml 내용:"
	@grep "persistent_peers" ~/.opstrad/config/config.toml
	@grep "timeout_commit" ~/.opstrad/config/config.toml

# 정리
clean:
	@echo "==> 설치 파일 정리 중..."
	@rm -rf ~/.opstrad
	@echo "==> 정리 완료"

# 도움말
help:
	@echo "사용 가능한 명령어:"
	@echo "  make install    - opstrad 설치"
	@echo "  make init       - opstrad 초기화"
	@echo "  make start      - 노드 시작"
	@echo "  make stop       - 노드 정지"
	@echo "  make connect NODE=<노드ID>@<IP>:<포트> - 다른 노드와 연결"
	@echo "  make config     - 설정 파일 확인"
	@echo "  make clean      - 설치 파일 정리"
	@echo "  make help       - 도움말 표시"