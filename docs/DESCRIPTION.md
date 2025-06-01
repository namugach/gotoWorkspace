# gotoWorkspace - 상세 설명

## 📋 개요

gotoWorkspace는 터미널에서 자주 사용하는 디렉토리들을 번호로 관리하고 빠르게 이동할 수 있게 해주는 유틸리티입니다.

## 🎯 해결하는 문제

### Before (기존 방식)
```bash
cd /very/long/path/to/project/frontend
cd /another/very/long/path/to/backend
cd /yet/another/long/path/to/documents
```

### After (gotoWorkspace 사용)
```bash
goto 1  # frontend
goto 2  # backend  
goto 3  # documents
```

## 🚀 핵심 기능

### 1. 경로 번호 관리
- 자주 가는 디렉토리를 번호로 등록
- 추가된 순서대로 자동 번호 생성
- 언제든지 수정/삭제 가능

### 2. 빠른 이동
- `goto 1`, `goto 2` 형태로 즉시 이동
- `goto root` 또는 `goto 0`으로 기본 위치 이동
- 현재 위치 추가: `goto list add pwd`

### 3. 기본 위치 설정
- 터미널 시작시 자동으로 이동할 위치 설정
- `goto select update 2` 형태로 기본 위치 변경

## 🛠️ 기술적 특징

### Multi-Shell 지원
- **bash**: `.bashrc` 자동 설정
- **zsh**: `.zshrc` 자동 설정  
- **기타**: `.profile` fallback 지원

### 안정적인 설치
- `~/.gotoworkspace` 고정 경로 사용
- 프로젝트 디렉토리 이동에 영향받지 않음
- 설정 파일 자동 백업

### 완전한 관리
- **설치**: 원클릭 자동 설정
- **제거**: 모든 흔적 완전 삭제
- **업데이트**: 사용자 데이터 보존

## 💡 사용 시나리오

### 개발자
```bash
goto list add /home/user/projects/frontend
goto list add /home/user/projects/backend
goto list add /home/user/projects/mobile

goto 1  # frontend 프로젝트로 이동
goto 2  # backend 프로젝트로 이동
```

### 시스템 관리자
```bash
goto list add /etc/nginx
goto list add /var/log
goto list add /home/user/scripts

goto 1  # nginx 설정으로 이동
goto 2  # 로그 확인으로 이동
```

## 🔍 동작 원리

1. **설치시**: 
   - `src/` 파일들을 `~/.gotoworkspace/`에 복사
   - shell 설정 파일에 source와 alias 추가

2. **실행시**:
   - `goto` 명령어는 `~/.gotoworkspace/run.sh` 실행
   - `list` 파일에서 경로 목록 읽기
   - `select` 파일에서 기본 경로 확인

3. **데이터 저장**:
   - `~/.gotoworkspace/list`: 등록된 경로들
   - `~/.gotoworkspace/select`: 기본 경로

## 🎨 사용자 경험

### 직관적인 명령어
- `goto`: 목록 보기
- `goto 1`: 1번으로 이동
- `goto list add`: 현재 위치 추가
- `goto -help`: 도움말

### 친숙한 패턴
- Unix/Linux 전통을 따르는 명령어 구조
- 짧고 기억하기 쉬운 명령어
- 일관된 옵션 체계

## 🔒 안전성

- 설정 파일 자동 백업
- 잘못된 경로 입력시 에러 처리  
- 제거시 완전한 정리
- 기존 설정 덮어쓰기 방지 