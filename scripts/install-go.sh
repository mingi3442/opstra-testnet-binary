#!/bin/bash
# install-go.sh - 리눅스 환경에서 Go 설치를 위한 스크립트

echo "==> Go 설치 스크립트 시작"

# Go 설치
GO_VERSION="go1.21.6"

cd $HOME

echo "==> Go ${GO_VERSION} 다운로드 중..."
wget https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz
echo "==> Go 압축 해제 중..."
tar -xvf ${GO_VERSION}.linux-amd64.tar.gz
echo "==> Go 설치 중..."
sudo mv go /usr/local/
mkdir -p $HOME/go/bin/

echo "==> 임시 파일 정리 중..."
rm ${GO_VERSION}.linux-amd64.tar.gz

GOROOT=/usr/local/go
GOPATH=$HOME/go

# .profile 파일에 Go 환경 변수 추가
if ! grep -q "GOROOT" $HOME/.profile; then
  echo "==> Go 환경 변수 설정 중..."
  cat << EOF >> $HOME/.profile

# Go 환경 변수
export GOROOT=$GOROOT
export GOPATH=$GOPATH
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH
EOF
fi

# 환경 변수 즉시 적용
export GOROOT=$GOROOT
export GOPATH=$GOPATH
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Go 버전 확인
echo "==> Go 버전 확인 중..."
go version

echo "==> Go 설치가 완료되었습니다."
echo "==> 변경사항을 적용하려면 다음 명령어를 실행하세요: source $HOME/.profile"