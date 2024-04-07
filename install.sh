#!/bin/bash
function getShellName() {
	parent_pid=$(ps -o ppid= -p $$)
	parent_name=$(ps -o comm= -p $parent_pid)
	echo "$parent_name"
}

function getUserHomePath() {
	echo "/home/$USER"
}

function getDotShellrc() {
	echo .$(getShellName)rc
}

function getDotShellrfFullPathFile() {
	echo "$(getUserHomePath)/$(getDotShellrc)"
}

function getDotProfileFullPathFile() {
	echo "$(getUserHomePath)/.profile"
}

function createPrefixGotoPathRegex() {
	local prefix=$1
	echo "^$prefix.*gotoWorkspace\/run.sh.*"
}

function programPath() {
	local _currentPath=$1
	if [ $currentPath  = '.' ]; then
		pwd
	else
		cd $currentPath
		pwd
	fi
}



##############################메시지

function installStartMessage() {
	echo "
	엔터를 누르면 바로 설치가 시작됩니다.
	원하시는 사항을 선택해 주세요.
	설치를 중지하려면 Ctrl+c를 누르세요

	1.설치
	2.삭제


	"
}

function setProfileAddSourceMessage() {
	echo "
	$(getDotProfileFullPathFile), $(getDotShellrfFullPathFile) 파일에 
	alias 이름을 goto라고 등록함.

	이게 마음에 드시면 그냥 엔터를 누르고,

	그게 아니라면 사용하고싶은 alias 이름을 적어주세요.

	참고로 전에 등록된 이름이 있다면 여기서 변경 하면 되고,
	전에 있던 이름에 덮어 쓰입니다.
	"
}

function completeMessage() {
	echo "
	작업이 완료 됐습니다.
	-----------------------------


	source $(getDotShellrfFullPathFile)
	

	-----------------------------
	명령창에 위의 명령을 입력하세요
	"

}
##############################기능구현

function setInput() {
	read -p "값을 입력하세요 : " input
	if [ -z $input ]; then
		echo $1
	else
		echo $input
	fi
}


function overwrite() {
	local filePath=$1
	local search=$2
	local content=$3
	sed -i "s|$search|$content|" "$filePath"
}

function add() {
	local filePath="$1"
	local content=$2
	echo $content >> $filePath
}


function update() {
	local filePath=$1
	local search=$2
	local content=$3
	if grep -q "$search" "$filePath"; then
		overwrite "$filePath" "$search" "$content"
	else
		add "$filePath" "$content"
	fi
}

function delete() {
	local filePath=$1
	local search=$2
	update "$filePath" "$search" ""
}

function createAliasPath() {
	echo "alias $1='source $(programPath)/run.sh'"
}


function setAslias() {
	local filePath=$1
	local search=$2
	local content=`createAliasPath $3`
	update "$filePath" "$search" "$content"
}




function getRunPath() {
	echo "source $(programPath)/run.sh root"
}

function setShellrcRun() {
	local filePath=$1
	local search=$2
	local content=$(getRunPath)
	update "$filePath" "$search" "$content"
}



function setRunPath() {
	local _currentPath=$1
	update "$_currentPath/run.sh" "currentPath=.*" "currentPath='$_currentPath'"
}

function setSelect() {
	echo $(getUserHomePath) > $currentPath/select
}

##############################main

function main() {

	local isInstallFile=`ls | grep "run.sh"`

	if [ $isInstallFile = "run.sh" ]; then
		# alias_key 덮어쓰기

		# .shellrc 추가, 덮어쓰기, alias_key에 의한 삭제
		# - alias, source

		# .prifile 추가, 덮어쓰기, alias_key에 의한 삭제
		# - alias

		# run.sh 추가, 덮어쓰기
		# - currentPath

		# 경로, 파일명, 위치

		local currentPath="$(pwd)"

		local shellrc="$(getDotShellrfFullPathFile)"
		local profile="$(getDotProfileFullPathFile)"

		local gotoAliasPathRegex=$(createPrefixGotoPathRegex "alias")
		local gotoSourcePathRegex=$(createPrefixGotoPathRegex "source")


		local aliasKey="goto"
		installStartMessage
		installType=`setInput 1`

		if [ -z $installType -o $installType -eq 1 ]; then
			setProfileAddSourceMessage
			aliasKey=`setInput "goto"`

			setShellrcRun "$shellrc" "$gotoSourcePathRegex"
			setAslias "$shellrc" "$gotoAliasPathRegex" "$aliasKey"
			setAslias "$profile" "$gotoAliasPathRegex" "$aliasKey"

			setRunPath "$currentPath"
			update "$currentPath"/list $(getUserHomePath) $(getUserHomePath)
			setSelect

			# echo $(getUserHomePath) >> $currentPath/list

			completeMessage

		elif [ $installType -eq 2 ]; then
			delete "$shellrc" "$gotoSourcePathRegex"
			delete "$shellrc" "$gotoAliasPathRegex"
			delete "$profile" "$gotoAliasPathRegex"
			echo "
			삭제 완료.
			"
			completeMessage
		fi

	echo "
	version    : gotoWorkspace v0.2.1
	developer  : namugach
	github     : https://github.com/namugach/gotoWorkspace
	"


	else
		echo "run.sh 파일이 없습니다"

	fi

}

main