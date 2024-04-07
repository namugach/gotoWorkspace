## 1.설명
이 프로그램은  
자주 쓰는 디렉토리 경로를 추가하여 저장해두고  
이동할 수 있게 해주는 도우미 프로그램입니다.  


먼저 디렉토리 경로를 추가하여 저장하면  
추가된 순서대로 번호가 생성됩니다.  

생성된 번호를 지정해서   
빠르게 디렉토리 체인지를 할 수 있으며  

리눅스 터미널 로그인 시  
원하는 디렉토리로 자동 이동하고 싶을 때  
.bachrc파일에 명령어를 따로 추가하지 않고  

이동할 수 있게 해줍니다.  

크게 root, list, select, -help 등의 명령어로 이루어졌고,  
list는 보기, 추가, 수정, 삭제 등을 할 수 있으며,  
select는 root 명령어가 수행하여 이동하는 경로를 리스트에서  
확인, 수정할 수 있는 기능으로 이뤄졌습니다.

자세한 사항은 아래의 안내서에서 확인하세요.

---

## 2.설치


### 2.1. install.sh
- 다운로드 받은 파일이 있는 곳에서 source install.sh 를 입력합니다.
- 설치 안내에 따라서 진행합니다.

		

### 2.2. 수동설치
#### 2.2.1. .bachrc 파일에 내용추가	

~/.bachrc 파일 하단에 아래의 해당하는 내용을 입력하세요  
source /gotoWorksapce디렉토리 경로/run.sh root

```sh
source /home/user/gotoWorksapce/run.sh root
```

#### 2.2.2. .profile 파일에 내용추가

~/.profile 파일 하단에 아래의 해당하는 내용을 입력하세요.  
alias 별명="source /gotoWorksapce디렉토리 경로/run.sh"
```sh
alias goto="source /home/user/gotoWorksapce/run.sh"
```

#### 2.2.3. .bachrc .profile의 변경된 사항 시스템에 적용하기
```sh
source ~/.bachrc
(엔터)
source ~/.profile
(엔터)
```
---

## 3. 사용법

이 프로그램의 최대 인자값은 4개.  
크게 list, select, root, -help 등의 명령어로 이루어졌습니다.


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
	developer  : TheName
	github     : https://github.com/namugach/gotoWorkspace
	thanks     : F(진지), dhtmdgkr123(Matas)[엄청]
