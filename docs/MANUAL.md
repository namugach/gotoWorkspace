# 사용 설명서

## 📖 개요

gotoWorkspace의 모든 명령어와 사용법을 상세히 설명합니다.

- **최대 인자 값**: 4개
- **인자 종류**: list, select, root, -help

---

## 🗂️ list 명령어

경로 목록을 관리하는 명령어입니다.

### 옵션
- `show` - 목록 보기
- `add` - 경로 추가
- `edit` - 경로 수정
- `del` - 경로 삭제

---

### list show

등록된 경로 목록을 보여줍니다.

**입력**
```bash
goto list show
```

**출력**
```
================================================
도움말 옵션 -help [ -h ]
▼ 현재 select 값
/home/user/
================================================
1. /home
2. /usr/local
3. /etc
```

---

### list add

새로운 경로를 목록에 추가합니다.

**입력**
```bash
goto list add /etc/nginx
```

**출력**
```
================================================
/etc/nginx를 리스트에 항목을 추가함
================================================
1. /home
2. /usr/local
3. /etc
4. /etc/nginx <--- 
```

#### 특별 옵션: pwd / this

현재 위치한 디렉토리를 추가할 때 사용합니다.

**입력**
```bash
goto list add pwd
# 또는
goto list add this
```

---

### list edit

목록에서 특정 번호의 경로를 수정합니다.

**입력**
```bash
goto list edit 1 /lib
```

**출력**
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

### list del

목록에서 특정 번호의 경로를 삭제합니다.

**입력**
```bash
goto list del 1
```

**출력**
```
================================================
/lib
삭제
================================================
1. /usr/local
2. /etc
3. /etc/nginx
```

#### 전체 삭제 옵션: -all / -a

목록의 모든 항목을 삭제합니다.

**입력**
```bash
goto list del -all 
# 또는
goto list del -a
```

**출력**
```
list에 있는 내용을 모두 삭제했습니다.

list에 아무런 값도 없습니다.
list add 명령어를 사용하여
항목을 추가하세요.
```

---

## 🎯 select 명령어

기본 위치를 설정하고 관리하는 명령어입니다.

### 옵션
- `show` - 현재 선택된 기본 위치 보기
- `update` / `up` - 기본 위치 업데이트

---

### select show

현재 설정된 기본 위치를 목록에서 표시합니다.

**입력**
```bash
goto select show
# 또는
goto sel show
```

**출력**
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

### select update

기본 위치를 목록의 특정 번호로 변경합니다.

**입력**
```bash
goto select update 2 
# 또는
goto select up 2
```

**출력**
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

---

## 🏠 root 명령어

설정된 기본 위치로 즉시 이동합니다.

**입력**
```bash
goto root 
# 또는
goto r 
# 또는
goto 0
```

**출력**
```
/usr/local 로 이동했습니다.
```

---

## 🔢 번호로 이동

목록의 번호를 직접 입력하여 해당 경로로 이동합니다.

**입력**
```bash
goto 1  # 1번 경로로 이동
goto 2  # 2번 경로로 이동
goto 3  # 3번 경로로 이동
```

**출력**
```
1. /home
2. /usr/local <---
3. /etc

/usr/local 로 이동
```

---

## ❓ 도움말

언제든지 도움말을 확인할 수 있습니다.

**전체 도움말**
```bash
goto -help
# 또는
goto -h
```

**list 도움말**
```bash
goto list -help
# 또는  
goto list -h
```

**select 도움말**
```bash
goto select -help
# 또는
goto sel -h
```

---

## 🚀 빠른 참조

### 자주 사용하는 명령어
```bash
goto                    # 현재 목록 보기
goto 1                  # 1번으로 이동
goto list add pwd       # 현재 위치 추가
goto select up 2        # 기본 위치를 2번으로 변경
goto root               # 기본 위치로 이동
```

### 관리 명령어
```bash
goto list show          # 목록 확인
goto list edit 1 /new   # 1번 경로 수정
goto list del 3         # 3번 경로 삭제
goto list del -all      # 전체 삭제
``` 