#!/bin/bash

##############################유틸리티 함수

function getShellName() {
    # 더 안전한 방법들을 순서대로 시도
    if [ -n "$ZSH_VERSION" ]; then
        echo "zsh"
    elif [ -n "$BASH_VERSION" ]; then
        echo "bash"
    else
        # fallback: $0에서 추출
        basename "$0" | sed 's/^-//'
    fi
}

function getUserHomePath() {
    echo "$HOME"
}

function getInstallPath() {
    echo "$(getUserHomePath)/.gotoworkspace"
}

function getDotShellrc() {
    local shell_name=$(getShellName)
    echo ".${shell_name}rc"
}

function getDotShellrcFullPath() {
    local home_path=$(getUserHomePath)
    local shellrc_name=$(getDotShellrc)
    local shellrc_path="$home_path/$shellrc_name"
    
    # 파일이 존재하는지 확인하고, 없으면 .bashrc로 fallback
    if [ -f "$shellrc_path" ]; then
        echo "$shellrc_path"
    else
        echo "$home_path/.bashrc"
    fi
}

function getDotProfileFullPath() {
    echo "$(getUserHomePath)/.profile"
}

function createBackupFile() {
    local file_path=$1
    if [ -f "$file_path" ]; then
        cp "$file_path" "${file_path}.gotoworkspace.backup.$(date +%Y%m%d_%H%M%S)"
        echo "백업 파일 생성: ${file_path}.gotoworkspace.backup.$(date +%Y%m%d_%H%M%S)"
    fi
}

##############################메시지 함수

function showHeader() {
    echo "================================================"
    echo "           gotoWorkspace 설치 도구"
    echo "================================================"
}

function installStartMessage() {
    showHeader
    echo ""
    echo "설치 옵션을 선택해주세요:"
    echo "1. 설치 (기본)"
    echo "2. 제거"
    echo "3. 업데이트"
    echo ""
    echo "엔터를 누르면 설치가 시작됩니다."
    echo "중지하려면 Ctrl+C를 누르세요."
    echo ""
}

function aliasNameMessage() {
    echo ""
    echo "alias 이름을 설정해주세요 (기본: goto):"
    echo "현재 shell: $(getShellName)"
    echo "설정 파일: $(getDotShellrcFullPath)"
    echo ""
}

function completeMessage() {
    local shell_rc=$(getDotShellrcFullPath)
    echo ""
    echo "================================================"
    echo "           설치가 완료되었습니다!"
    echo "================================================"
    echo ""
    echo "다음 명령을 실행하여 설정을 적용하세요:"
    echo "  source $shell_rc"
    echo ""
    echo "또는 새 터미널을 열어주세요."
    echo ""
    echo "사용법:"
    echo "  goto           # 현재 목록 보기"
    echo "  goto 1         # 1번 경로로 이동"
    echo "  goto list add  # 현재 경로 추가"
    echo ""
}

function removeCompleteMessage() {
    echo ""
    echo "================================================"
    echo "           제거가 완료되었습니다!"
    echo "================================================"
    echo ""
}

##############################핵심 기능

function setInput() {
    local default_value=$1
    local input
    read -p "값을 입력하세요 (기본: $default_value): " input
    if [ -z "$input" ]; then
        echo "$default_value"
    else
        echo "$input"
    fi
}

function removeLineContaining() {
    local file_path=$1
    local search_pattern=$2
    
    if [ -f "$file_path" ]; then
        # 임시 파일 생성
        local temp_file=$(mktemp)
        grep -v "$search_pattern" "$file_path" > "$temp_file"
        mv "$temp_file" "$file_path"
    fi
}

function addOrUpdateLine() {
    local file_path=$1
    local search_pattern=$2
    local new_line=$3
    
    # 파일이 없으면 생성
    touch "$file_path"
    
    # 기존 라인 제거 후 새 라인 추가
    removeLineContaining "$file_path" "$search_pattern"
    echo "$new_line" >> "$file_path"
}

function installFiles() {
    local install_path=$(getInstallPath)
    
    echo "설치 디렉토리 생성: $install_path"
    mkdir -p "$install_path"
    
    # src 디렉토리 확인
    if [ ! -d "src" ]; then
        echo "❌ 오류: src 디렉토리를 찾을 수 없습니다."
        echo "   이 스크립트는 프로젝트 루트 디렉토리에서 실행해야 합니다."
        exit 1
    fi
    
    echo "파일 복사 중..."
    cp src/* "$install_path/"
    
    # 실행 권한 설정
    chmod +x "$install_path/run.sh"
    
    # run.sh의 currentPath 수정
    sed -i "s|currentPath=.*|currentPath='$install_path'|" "$install_path/run.sh"
    
    echo "✅ 파일 설치 완료"
}

function setupShellConfig() {
    local alias_name=$1
    local install_path=$(getInstallPath)
    local home_path=$(getUserHomePath)
    
    echo "Shell 설정 파일 수정 중..."
    
    # 설정할 내용들
    local source_line="source $install_path/run.sh root"
    local alias_line="alias $alias_name='source $install_path/run.sh'"
    
    # bash 설정 (.bashrc)
    local bashrc_path="$home_path/.bashrc"
    if [ -f "$bashrc_path" ]; then
        createBackupFile "$bashrc_path"
        addOrUpdateLine "$bashrc_path" "$install_path/run.sh" "$source_line"
        addOrUpdateLine "$bashrc_path" "$alias_name=" "$alias_line"
        echo "✅ .bashrc 설정 완료"
    fi
    
    # zsh 설정 (.zshrc)
    local zshrc_path="$home_path/.zshrc"
    if [ -f "$zshrc_path" ]; then
        createBackupFile "$zshrc_path"
        addOrUpdateLine "$zshrc_path" "$install_path/run.sh" "$source_line"
        addOrUpdateLine "$zshrc_path" "$alias_name=" "$alias_line"
        echo "✅ .zshrc 설정 완료"
    fi
    
    # profile 설정 (다른 shell 호환성을 위해)
    local profile_path="$home_path/.profile"
    if [ -f "$profile_path" ]; then
        createBackupFile "$profile_path"
        addOrUpdateLine "$profile_path" "$alias_name=" "$alias_line"
        echo "✅ .profile 설정 완료"
    fi
    
    echo "✅ Shell 설정 완료"
}

function removeInstallation() {
    local install_path=$(getInstallPath)
    local home_path=$(getUserHomePath)
    
    echo "제거 중..."
    
    # 디렉토리 제거
    if [ -d "$install_path" ]; then
        rm -rf "$install_path"
        echo "✅ 설치 디렉토리 제거: $install_path"
    fi
    
    # bash 설정 파일 정리 (.bashrc)
    local bashrc_path="$home_path/.bashrc"
    if [ -f "$bashrc_path" ]; then
        removeLineContaining "$bashrc_path" ".gotoworkspace"
        echo "✅ .bashrc 정리 완료"
    fi
    
    # zsh 설정 파일 정리 (.zshrc)
    local zshrc_path="$home_path/.zshrc"
    if [ -f "$zshrc_path" ]; then
        removeLineContaining "$zshrc_path" ".gotoworkspace"
        echo "✅ .zshrc 정리 완료"
    fi
    
    # profile 설정 파일 정리 (.profile)
    local profile_path="$home_path/.profile"
    if [ -f "$profile_path" ]; then
        removeLineContaining "$profile_path" ".gotoworkspace"
        echo "✅ .profile 정리 완료"
    fi
    
    echo "✅ Shell 설정 정리 완료"
}

function updateInstallation() {
    echo "업데이트 중..."
    
    # 기존 설정 보존하면서 파일만 업데이트
    local install_path=$(getInstallPath)
    
    if [ ! -d "$install_path" ]; then
        echo "❌ 기존 설치를 찾을 수 없습니다. 새로 설치해주세요."
        exit 1
    fi
    
    # 설정 파일 백업
    if [ -f "$install_path/list" ]; then
        cp "$install_path/list" "$install_path/list.backup"
    fi
    if [ -f "$install_path/select" ]; then
        cp "$install_path/select" "$install_path/select.backup"
    fi
    
    # 새 파일 복사
    cp src/run.sh "$install_path/"
    chmod +x "$install_path/run.sh"
    
    # currentPath 수정
    sed -i "s|currentPath=.*|currentPath='$install_path'|" "$install_path/run.sh"
    
    # 설정 파일 복원
    if [ -f "$install_path/list.backup" ]; then
        mv "$install_path/list.backup" "$install_path/list"
    fi
    if [ -f "$install_path/select.backup" ]; then
        mv "$install_path/select.backup" "$install_path/select"
    fi
    
    echo "✅ 업데이트 완료"
}

##############################메인 함수

function main() {
    # run.sh 파일 존재 확인
    if [ ! -f "src/run.sh" ]; then
        echo "❌ 오류: src/run.sh 파일을 찾을 수 없습니다."
        echo "   이 스크립트는 gotoWorkspace 프로젝트 루트에서 실행해야 합니다."
        exit 1
    fi
    
    installStartMessage
    local install_type=$(setInput "1")
    
    case $install_type in
        1|"")
            # 설치
            echo ""
            echo "🚀 설치를 시작합니다..."
            
            aliasNameMessage
            local alias_name=$(setInput "goto")
            
            installFiles
            setupShellConfig "$alias_name"
            completeMessage
            ;;
        2)
            # 제거
            echo ""
            echo "🗑️  제거를 시작합니다..."
            removeInstallation
            removeCompleteMessage
            ;;
        3)
            # 업데이트
            echo ""
            echo "🔄 업데이트를 시작합니다..."
            updateInstallation
            echo ""
            echo "✅ 업데이트가 완료되었습니다!"
            ;;
        *)
            echo "❌ 잘못된 선택입니다."
            exit 1
            ;;
    esac
    
    echo ""
    echo "================================================"
    echo "version    : gotoWorkspace v0.3.0"
    echo "developer  : namugach"
    echo "github     : https://github.com/namugach/gotoWorkspace"
    echo "================================================"
}

# 스크립트 실행
main 