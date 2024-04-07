## 1.설명
디렉토리 경로 관리 유틸 

### 기본
- 경로 추가시 추가된 순서대로 번호 생성.
- 단축 번호 지정해서 빠르세 디렉토리 체인지
- 최초 로그인시 지정된 디렉토리로 자동 이동

### 옵션
- root: 지정된 기본 위치
- list: 보기, 추가, 수정, 삭제
- select: root 지정
- -help
---

## 2.설치


### 2.1. install.sh
> 주의사항
```
다운로드 된 디렉토리 안에 들어가서 install 해야하며
설치하고 디렉토리를 이동하면 경로가 꼬임으로
설치 할 때, 미리 원하는 디렉토리로 이동하여 설치 할 것.
```
> 입력
```sh
./install.sh.
```


		

### 2.2. 수동설치
#### 2.2.1. .bashrc 혹은 .zshrc 파일에 내용추가	

~/.bashrc 혹은 .zshrc  

> source /gotoWorksapce디렉토리 경로/run.sh root

```sh
source /home/user/gotoWorksapce/run.sh root
```

#### 2.2.2. .profile 파일에 내용추가

~/.profile  

> alias 별명="source /gotoWorksapce디렉토리 경로/run.sh"
```sh
alias goto="source /home/user/gotoWorksapce/run.sh"
```

#### 2.2.3. .bashrc .profile의 변경된 사항 시스템에 적용하기
```sh
source ~/.bashrc
# 혹은
source ~/.zshrc


source ~/.profile
```
---

## 3. 사용법

- 최대 인자 값: 4
- 인자 종류: list, select, root, -help


### 3.1. list
> 옵션
- show
- add
- edit
- del

---

#### 3.1.1. show

list에 등록된 주소를 보여줍니다.


> 입력
```sh
goto list show
```


> 출력
```
================================================
도움말 옵션 -help [ -h ]
▼ 현재 select 값
/home/user/
================================================
1./home
2./usr/local
3./etc
```



---

#### 3.1.2. add
list에 원하는 path를 추가합니다.

> 입력
```sh
goto list add /ect/nginx
```


> 출력
```
================================================
/etc/nginx/modules를 리스트에 항목을 추가함
================================================
1. /home
2. /usr/local
3. /etc
4. /etc/nginx <--- 
```


##### 3.1.2.1. 옵션
 > pwd [ this ] 
- 현제 위치한 주소를 추가할 때 사용합니다.
- pwd 키워드 대신 this로도 사용할 수 있습니다.



> 입력
```sh
goto list add pwd
# 혹은
goto list add this
```

---


#### 3.1.3. edit
list에 원하는 번호의 값을 수정합니다.


> 입력
```sh
goto list edit 1 /lib
```
	
	
> 출력
```
================================================
###수정###
/home
▼ (수정성공)▼ 
/lib
================================================
1. /lib
2. /usr/local
3. /etc
4. /etc/nginx
```


---

#### 3.1.4 del
list의 원하는 번호의 값을 제거합니다.


> 입력
```sh
goto list del 1
```


> 출력
```
================================================
/lib
삭제
================================================
1. /usr/local
2. /etc
3. /etc/nginx
```


* ##### 3.1.4.1. 옵션
> -all [ -a ]
- list에 있는 모든 리스트들을 삭제합니다.
- -all 대신 -a 를 옵션으로 사용해도 작동합니다.

> 입력
```sh
goto list del -all 
# 혹은
goto list del -a
```
		
		
> 출력
```
lsit에 있는 내용을 모두 삭제했습니다.

list에 아무런 값도 없습니다.
list add 명령어를 사용하여
항목을 추가하세요.
```




---

### 3.2. select [ sel ]
기본이 될 리스트를 선택합니다.

> 옵션
- show
- update

	
#### 3.2.1. show

select에 등록된 값을   
list에 출력하여 표시하며 보여줍니다.  
select 인자값에 아무것도 주지 않아도 실행됩니다.  

- 차이 : 도움말이 표시되지 않습니다.

> 입력
```sh
goto select show
# 혹은
goto sel show
```
	
> 출력
```
================================================
현재 지정된 select 값은 아래와 같음
--> /home
================================================
1. /home <---
2. /usr/local
3. /etc
```

---

### 3.3. update [ up ]
> select
- select에 값을 업데이트 시킵니다.
- 인자 값으 list에 등록된 번호를 사용합니다.

> 입력
```sh
goto select update 2 
# 혹은
goto select up 2
```

> 출력
```
================================================
###업데이트###
/home
▼ 
/usr/local
================================================
1. /home
2. /usr/local <---
3. /etc
```


### 3.4. root [ r, 0 ]
select에 update 된 값으로 바로 이동합니다.

> 입력
```sh
goto root 
# 혹은
goto r 
# 또는
goto 0
```
		
		
> 출력
```
/usr/local 로 이동했습니다.
```

--- 
## etc
	version    : gotoWorkspace v0.2.1
	developer  : namugach
	github     : https://github.com/namugach/gotoWorkspace
	thanks     : F(진지), dhtmdgkr123(Matas)[엄청]
