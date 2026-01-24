---
name: docker-deploy
description: Docker 이미지 기반 배포 환경을 자동으로 구성합니다. /docker-deploy 명령으로 Dockerfile, docker-compose, install.bat 등 배포에 필요한 모든 파일을 생성합니다.
license: MIT
metadata:
  author: user
  version: "1.0.0"
---

# Docker Deploy Skill

Docker 이미지 기반 배포 파일을 자동 생성하는 스킬입니다.

## Skill Description

프로젝트의 Docker 배포 환경을 자동으로 구성합니다.

**Triggers:**
- `/docker-deploy` - 전체 Docker 배포 파일 생성
- `/docker-deploy build` - 이미지 빌드 스크립트만 생성
- `/docker-deploy install` - install.bat만 생성

**생성되는 파일:**
- `backend/Dockerfile` - Backend 멀티스테이지 빌드 (보호 옵션에 따라 Cython/PyArmor 포함)
- `frontend/Dockerfile` - Frontend 멀티스테이지 빌드
- `docker-compose.yml` - 개발용 (이미지 빌드)
- `docker-compose.prod.yml` - 프로덕션 오버라이드
- `docker-build-images.bat/.sh` - 이미지 빌드 스크립트
- `docker-images/docker-compose.yml` - 배포용 (pre-built 이미지)
- `docker-images/install.bat/.sh` - 처음 설치
- `docker-images/update.bat/.sh` - 소스코드 업데이트
- `docker-images/reset.bat/.sh` - 완전 초기화
- `docker-images/logs.bat/.sh` - 로그 보기
- `docker-images/cleanup.bat/.sh` - 이미지/컨테이너 정리
- `docker-images/.env` - 환경변수 (기본값 포함, 바로 실행 가능)

---

## Instructions

### 1. 프로젝트 분석

먼저 프로젝트 구조를 분석합니다:

```
- backend/ 폴더 확인 → Python/FastAPI, Node.js 등
- frontend/ 폴더 확인 → React, Vue 등
- 기존 Dockerfile 확인
- 기존 docker-compose.yml 확인
- package.json, requirements.txt 등 의존성 파일 확인
```

### 2. 프로젝트명 결정

프로젝트명은 다음 순서로 결정:
1. 사용자가 지정한 이름
2. package.json의 name
3. 폴더명

프로젝트명은 소문자, 하이픈 사용 (예: `medicode`, `my-project`)

### 3. OS 및 포트 설정 (사용자에게 질문)

#### 3.1 OS 선택

```
배포 대상 OS를 선택해주세요:

1. Windows (bat 스크립트)
2. Linux/Mac (sh 스크립트)
3. 둘 다 (bat + sh)
```

**AskUserQuestion 사용:**
- Windows만: .bat 파일만 생성
- Linux/Mac만: .sh 파일만 생성
- 둘 다: .bat + .sh 모두 생성

#### 3.2 소스코드 보호 (Python 프로젝트)

Backend가 Python인 경우 소스코드 보호 여부를 물어봅니다:

```
Python 소스코드 보호가 필요합니까?

| 옵션 | 보호 수준 | 설명 |
|------|----------|------|
| 없음 | - | 소스코드 그대로 배포 |
| Cython | 높음 | .py → .so 컴파일 (권장) |
| PyArmor | 높음 | 난독화 + 암호화 |

※ 소스코드 보호 시 빌드 시간이 증가합니다.
※ 내부 서버용이면 보호 없이 배포해도 됩니다.
```

**AskUserQuestion 사용:**
- 없음: 기존 방식 그대로
- Cython: .so 파일로 컴파일하여 배포
- PyArmor: 난독화된 코드로 배포

#### 3.3 포트 설정

파일 생성 전에 사용자에게 포트 설정을 물어봅니다:

```
Docker 배포 환경을 구성합니다.

포트 설정이 필요합니다. 기본값을 사용하거나 변경해주세요.

| 서비스 | 기본 포트 | 용도 |
|--------|----------|------|
| Frontend | 8960 | 웹 브라우저 접속 (필수) |
| Backend | 8950 | Swagger 문서, API 테스트 (개발용) |
| MySQL | 3310 | HeidiSQL 등 DB 클라이언트 접속 (개발용) |

※ Docker 내부에서는 컨테이너끼리 자동 연결됩니다.
※ Backend/MySQL 포트는 외부에서 직접 접근할 때만 필요합니다.

다른 Docker 프로젝트와 포트 충돌을 피하려면:
- 프로젝트 A: Frontend 8960, Backend 8950, MySQL 3310
- 프로젝트 B: Frontend 8961, Backend 8951, MySQL 3311
- 프로젝트 C: Frontend 8962, Backend 8952, MySQL 3312

포트를 변경하시겠습니까?
```

**AskUserQuestion 사용:**
- Frontend 포트 (기본: 8960) - 웹 브라우저 접속용 (필수)
- Backend 포트 (기본: 8950) - Swagger 문서, API 테스트용 (개발용)
- MySQL 포트 (기본: 3310) - HeidiSQL 등 DB 클라이언트 접속용 (개발용)

사용자가 기본값 사용을 선택하면 기본 포트 사용.
사용자가 변경을 선택하면 각 포트 번호를 입력받음.

### 4. 포트 규칙

| 서비스 | 컨테이너 내부 | 호스트 포트 | 용도 |
|--------|--------------|------------|------|
| Frontend | 80 | {user_frontend_port} | 웹 브라우저 접속 (필수) |
| Backend | 8950 | {user_backend_port} | Swagger, API 테스트 (개발용) |
| MySQL | 3306 | {user_db_port} | HeidiSQL 접속 (개발용) |
| Redis | 6379 | - | 캐시 (내부 전용) |

- 컨테이너 내부 포트는 고정
- 호스트 포트는 사용자 입력값 또는 기본값 사용
- Docker 내부 통신은 컨테이너 이름 사용 (예: http://api:8950)

### 5. 파일 생성 규칙

#### Backend Dockerfile (FastAPI/Python)

```dockerfile
# ============================================
# Build stage - 의존성 설치
# ============================================
FROM python:3.11-slim as builder

WORKDIR /app

# 시스템 의존성 설치 (빌드용)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 의존성 먼저 복사 (캐시 활용)
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# ============================================
# Development stage - 개발용 (핫 리로드)
# ============================================
FROM python:3.11-slim as development

WORKDIR /app

# 비root 사용자 생성 (보안)
RUN useradd --create-home --shell /bin/bash appuser

COPY --from=builder /root/.local /home/appuser/.local
ENV PATH=/home/appuser/.local/bin:$PATH

COPY --chown=appuser:appuser . .

USER appuser
EXPOSE 8950

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8950", "--reload"]

# ============================================
# Production stage - 프로덕션용 (최적화)
# ============================================
FROM python:3.11-slim as production

WORKDIR /app

# 보안: 비root 사용자
RUN useradd --create-home --shell /bin/bash appuser

# curl 설치 (헬스체크용)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/.local /home/appuser/.local
ENV PATH=/home/appuser/.local/bin:$PATH
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY --chown=appuser:appuser . .

USER appuser
EXPOSE 8950

# 헬스체크
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8950/health || exit 1

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8950", "--workers", "4"]
```

#### Backend Dockerfile with Cython (소스코드 보호)

소스코드 보호가 필요한 경우 Cython으로 컴파일:

```dockerfile
# ============================================
# Build stage - Cython 컴파일
# ============================================
FROM python:3.11-slim as builder

WORKDIR /app

# 빌드 도구 설치
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 의존성 설치
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt
RUN pip install --user --no-cache-dir cython

# 소스 복사
COPY . .

# Cython 컴파일 스크립트 생성 및 실행
RUN echo 'import os\n\
import glob\n\
from setuptools import setup\n\
from Cython.Build import cythonize\n\
\n\
# 컴파일할 파일 목록 (main.py 제외 - uvicorn 진입점)\n\
py_files = []\n\
for root, dirs, files in os.walk("app"):\n\
    # __pycache__ 제외\n\
    dirs[:] = [d for d in dirs if d != "__pycache__"]\n\
    for f in files:\n\
        if f.endswith(".py") and f != "__init__.py" and f != "main.py":\n\
            py_files.append(os.path.join(root, f))\n\
\n\
if py_files:\n\
    setup(\n\
        ext_modules=cythonize(\n\
            py_files,\n\
            compiler_directives={"language_level": "3"}\n\
        )\n\
    )\n\
' > setup_cython.py

# Cython 컴파일 실행
RUN python setup_cython.py build_ext --inplace

# .py 파일 삭제 (main.py, __init__.py 제외)
RUN find app -name "*.py" ! -name "main.py" ! -name "__init__.py" -delete
RUN find app -name "*.c" -delete

# ============================================
# Production stage - 컴파일된 코드 실행
# ============================================
FROM python:3.11-slim as production

WORKDIR /app

# 보안: 비root 사용자
RUN useradd --create-home --shell /bin/bash appuser

# curl 설치 (헬스체크용)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 의존성 복사
COPY --from=builder /root/.local /home/appuser/.local
ENV PATH=/home/appuser/.local/bin:$PATH
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 컴파일된 코드 복사 (.so 파일 + main.py + __init__.py)
COPY --from=builder --chown=appuser:appuser /app/app /app/app
COPY --from=builder --chown=appuser:appuser /app/requirements.txt /app/

USER appuser
EXPOSE 8950

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8950/health || exit 1

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8950", "--workers", "4"]
```

#### Backend Dockerfile with PyArmor (난독화)

PyArmor를 사용한 소스코드 난독화:

```dockerfile
# ============================================
# Build stage - PyArmor 난독화
# ============================================
FROM python:3.11-slim as builder

WORKDIR /app

# 의존성 설치
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt
RUN pip install --user --no-cache-dir pyarmor

# 소스 복사
COPY . .

# PyArmor로 난독화
ENV PATH=/root/.local/bin:$PATH
RUN pyarmor gen --output dist/app app/

# ============================================
# Production stage - 난독화된 코드 실행
# ============================================
FROM python:3.11-slim as production

WORKDIR /app

# 보안: 비root 사용자
RUN useradd --create-home --shell /bin/bash appuser

# curl 설치 (헬스체크용)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 의존성 복사
COPY --from=builder /root/.local /home/appuser/.local
ENV PATH=/home/appuser/.local/bin:$PATH
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 난독화된 코드 복사
COPY --from=builder --chown=appuser:appuser /app/dist/app /app/app
COPY --from=builder --chown=appuser:appuser /app/requirements.txt /app/

USER appuser
EXPOSE 8950

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8950/health || exit 1

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8950", "--workers", "4"]
```

#### Frontend Dockerfile (React/Vite)

```dockerfile
# ============================================
# Build stage - 빌드
# ============================================
FROM node:20-alpine as builder

WORKDIR /app

# 의존성 먼저 복사 (캐시 활용)
COPY package*.json ./
RUN npm ci --silent

# 소스 복사 및 빌드
COPY . .
ARG VITE_API_URL=http://localhost:8950
ENV VITE_API_URL=$VITE_API_URL
RUN npm run build

# ============================================
# Production stage - Nginx 서빙
# ============================================
FROM nginx:alpine as production

# 보안: 불필요한 파일 제거
RUN rm -rf /usr/share/nginx/html/*

# 빌드 결과물 복사
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 보안: nginx 캐시 디렉토리 권한
RUN chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d

# 헬스체크
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

#### Frontend nginx.conf

```nginx
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://api:8950;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

#### docker-images/docker-compose.yml (배포용)

```yaml
version: '3.8'

services:
  api:
    image: {project}-api:latest
    container_name: {project}-api
    restart: unless-stopped
    ports:
      - "${API_PORT:-8950}:8950"  # Swagger, API 테스트 (개발용)
    environment:
      - ENVIRONMENT=production
      - DB_HOST=db
      - DB_PORT=3306
      - DB_NAME=${DB_NAME:-{project}_db}
      - DB_USER=${DB_USER:-root}
      - DB_PASSWORD=${DB_PASSWORD:-password}
      - REDIS_HOST=redis
      - REDIS_PORT=6379
      - SECRET_KEY=${SECRET_KEY:-change-this-secret-key}
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
    networks:
      - {project}-network
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8950/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  frontend:
    image: {project}-frontend:latest
    container_name: {project}-frontend
    restart: unless-stopped
    ports:
      - "${FRONTEND_PORT:-8960}:80"  # 웹 브라우저 접속 (필수)
    depends_on:
      - api
    networks:
      - {project}-network

  db:
    image: mysql:8.0
    container_name: {project}-db
    restart: unless-stopped
    ports:
      - "${DB_PORT:-3310}:3306"  # HeidiSQL 접속 (개발용)
    environment:
      - MYSQL_ROOT_PASSWORD=${DB_PASSWORD:-password}
      - MYSQL_DATABASE=${DB_NAME:-{project}_db}
    volumes:
      - mysql_data:/var/lib/mysql
      - ./schema.sql:/docker-entrypoint-initdb.d/01-schema.sql:ro
      - ./migrate.sql:/docker-entrypoint-initdb.d/02-migrate.sql:ro
    networks:
      - {project}-network
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5
    command: >
      --character-set-server=utf8mb4
      --collation-server=utf8mb4_unicode_ci

  redis:
    image: redis:7-alpine
    container_name: {project}-redis
    restart: unless-stopped
    volumes:
      - redis_data:/data
    networks:
      - {project}-network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 3

networks:
  {project}-network:
    driver: bridge

volumes:
  mysql_data:
  redis_data:
```

#### docker-build-images.bat

```batch
@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo.
echo ============================================
echo   {Project} Docker Image Build
echo ============================================
echo.

REM Docker 실행 확인
docker info >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker가 실행되고 있지 않습니다.
    exit /b 1
)

REM 출력 폴더 생성
if not exist "docker-images" mkdir docker-images

echo [1/4] Building Backend API image...
docker build -t {project}-api:latest -f backend/Dockerfile --target production backend/
if errorlevel 1 (
    echo [ERROR] Backend build failed.
    exit /b 1
)

echo [2/4] Building Frontend image...
docker build -t {project}-frontend:latest -f frontend/Dockerfile --target production frontend/
if errorlevel 1 (
    echo [ERROR] Frontend build failed.
    exit /b 1
)

echo [3/4] Saving images to tar file...
docker save {project}-api:latest {project}-frontend:latest -o docker-images/{project}-all.tar

echo [4/4] Copying deployment files...
REM .env는 docker-images/에 이미 기본값으로 존재
if exist database\schema.sql copy database\schema.sql docker-images\schema.sql >nul
if exist database\migrate.sql copy database\migrate.sql docker-images\migrate.sql >nul

echo.
echo ============================================
echo   Build Complete!
echo ============================================
echo.
echo Output folder: docker-images\
echo.
echo To create deployment zip:
echo   powershell Compress-Archive -Path 'docker-images/*' -DestinationPath '{project}-docker-deploy.zip'
echo.

endlocal
```

#### docker-images/install.bat

```batch
@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM ============================================
REM   {Project} Docker 설치/업데이트 스크립트
REM
REM   사용법:
REM     install.bat         - 처음 설치
REM     install.bat update  - 소스코드 업데이트 (DB 유지)
REM     install.bat reset   - 완전 초기화 (모든 데이터 삭제)
REM ============================================

set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

set "MODE=%~1"
if "%MODE%"=="" set "MODE=install"

echo.
echo ============================================
if "%MODE%"=="update" (
    echo   {Project} Docker 업데이트
) else if "%MODE%"=="reset" (
    echo   {Project} Docker 완전 초기화
) else (
    echo   {Project} Docker 설치
)
echo ============================================
echo.

REM Docker 실행 확인
echo [1/6] Docker 실행 상태 확인 중...
docker info >nul 2>&1
if errorlevel 1 (
    echo [오류] Docker가 실행되고 있지 않습니다.
    echo        Docker Desktop을 먼저 실행해주세요.
    pause
    exit /b 1
)
echo       Docker 정상 실행 중

REM reset 모드: 볼륨 삭제
if "%MODE%"=="reset" (
    echo.
    echo [경고] 완전 초기화를 선택하셨습니다.
    echo        모든 데이터베이스 데이터가 삭제됩니다!
    echo.
    set /p "CONFIRM=정말 초기화하시겠습니까? (yes/no): "
    if /i not "!CONFIRM!"=="yes" (
        echo 취소되었습니다.
        pause
        exit /b 0
    )
    echo.
    echo [2/6] 기존 서비스 및 데이터 삭제 중...
    docker-compose down -v >nul 2>&1
    docker rmi {project}-api:latest {project}-frontend:latest >nul 2>&1
    echo       삭제 완료
) else if "%MODE%"=="update" (
    echo.
    echo [2/6] 기존 서비스 중지 및 이미지 교체 준비 중...
    docker-compose down >nul 2>&1
    docker rmi {project}-api:latest {project}-frontend:latest >nul 2>&1
    echo       준비 완료
) else (
    echo.
    echo [2/6] 기존 설치 확인 중...
)

REM .env 파일 확인 (이미 기본값으로 포함되어 있어야 함)
echo.
echo [3/6] 환경 설정 파일 확인 중...
if not exist "%SCRIPT_DIR%.env" (
    echo [오류] .env 파일을 찾을 수 없습니다.
    echo        설치 파일이 손상되었을 수 있습니다.
    pause
    exit /b 1
)
echo       .env 파일 확인 완료

REM 이미지 로드
echo.
echo [4/6] Docker 이미지 로드 중...
if exist "%SCRIPT_DIR%{project}-all.tar" (
    docker image inspect {project}-api:latest >nul 2>&1
    if errorlevel 1 (
        echo       이미지 로드 중... (잠시 기다려주세요)
        docker load -i "%SCRIPT_DIR%{project}-all.tar"
        echo       이미지 로드 완료
    ) else (
        if "%MODE%"=="install" (
            echo       이미지가 이미 존재합니다.
            echo       업데이트가 필요하면 'install.bat update'를 실행하세요.
        ) else (
            echo       새 이미지 로드 완료
        )
    )
) else (
    echo [오류] {project}-all.tar 파일을 찾을 수 없습니다.
    pause
    exit /b 1
)

REM 베이스 이미지 다운로드
echo.
echo [5/6] 필수 이미지 확인 중...
docker image inspect mysql:8.0 >nul 2>&1 || docker pull mysql:8.0
docker image inspect redis:7-alpine >nul 2>&1 || docker pull redis:7-alpine
echo       완료

REM 서비스 시작
echo.
echo [6/6] 서비스 시작 중...
docker-compose up -d

if errorlevel 1 (
    echo [오류] 서비스 시작 실패
    echo        docker-compose logs 명령으로 로그를 확인하세요.
    pause
    exit /b 1
)

echo.
echo ============================================
if "%MODE%"=="update" (
    echo   업데이트 완료!
) else if "%MODE%"=="reset" (
    echo   초기화 완료!
) else (
    echo   설치 완료!
)
echo ============================================
echo.
echo   서비스 상태:
docker-compose ps
echo.
timeout /t 10 /nobreak >nul

echo.
echo ============================================
echo   접속 정보
echo ============================================
echo.
echo   웹: http://localhost:8960
echo   API: http://localhost:8950/docs
echo   DB: localhost:3310 (HeidiSQL)
echo.
echo ============================================
echo   명령어
echo ============================================
echo.
echo   로그 보기:     docker-compose logs -f
echo   서비스 중지:   docker-compose down
echo   서비스 재시작: docker-compose restart
echo   업데이트:      install.bat update
echo   완전 초기화:   install.bat reset
echo.

endlocal
pause
```

#### docker-images/update.bat

```batch
@echo off
REM 소스코드 업데이트 (DB 데이터 유지)
call "%~dp0install.bat" update
```

#### docker-images/reset.bat

```batch
@echo off
REM 완전 초기화 (모든 데이터 삭제)
call "%~dp0install.bat" reset
```

#### docker-images/logs.bat

```batch
@echo off
REM 실시간 로그 보기
cd /d "%~dp0"
docker-compose logs -f
```

#### docker-images/cleanup.bat

```batch
@echo off
chcp 65001 >nul
echo.
echo ============================================
echo   Docker 리소스 정리
echo ============================================
echo.
echo [1/3] 중지된 컨테이너 삭제...
docker container prune -f
echo.
echo [2/3] 사용하지 않는 이미지 삭제...
docker image prune -f
echo.
echo [3/3] 사용하지 않는 볼륨 삭제...
docker volume prune -f
echo.
echo 정리 완료!
pause
```

---

### Linux/Mac용 스크립트 (sh)

#### docker-build-images.sh

```bash
#!/bin/bash
# {Project} Docker Image Build

set -e

echo ""
echo "============================================"
echo "  {Project} Docker Image Build"
echo "============================================"
echo ""

# Docker 실행 확인
if ! docker info > /dev/null 2>&1; then
    echo "[ERROR] Docker가 실행되고 있지 않습니다."
    exit 1
fi

# 출력 폴더 생성
mkdir -p docker-images

echo "[1/4] Building Backend API image..."
docker build -t {project}-api:latest -f backend/Dockerfile --target production backend/

echo "[2/4] Building Frontend image..."
docker build -t {project}-frontend:latest -f frontend/Dockerfile --target production frontend/

echo "[3/4] Saving images to tar file..."
docker save {project}-api:latest {project}-frontend:latest -o docker-images/{project}-all.tar

echo "[4/4] Copying deployment files..."
# .env는 docker-images/에 이미 기본값으로 존재
[ -f database/schema.sql ] && cp database/schema.sql docker-images/schema.sql
[ -f database/migrate.sql ] && cp database/migrate.sql docker-images/migrate.sql

echo ""
echo "============================================"
echo "  Build Complete!"
echo "============================================"
echo ""
echo "Output folder: docker-images/"
echo ""
echo "To create deployment zip:"
echo "  zip -r {project}-docker-deploy.zip docker-images/"
echo ""
```

#### docker-images/install.sh

```bash
#!/bin/bash
# {Project} Docker 설치/업데이트 스크립트
#
# 사용법:
#   ./install.sh         - 처음 설치
#   ./install.sh update  - 소스코드 업데이트 (DB 유지)
#   ./install.sh reset   - 완전 초기화 (모든 데이터 삭제)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

MODE="${1:-install}"

echo ""
echo "============================================"
case "$MODE" in
    update) echo "  {Project} Docker 업데이트" ;;
    reset)  echo "  {Project} Docker 완전 초기화" ;;
    *)      echo "  {Project} Docker 설치" ;;
esac
echo "============================================"
echo ""

# Docker 실행 확인
echo "[1/6] Docker 실행 상태 확인 중..."
if ! docker info > /dev/null 2>&1; then
    echo "[오류] Docker가 실행되고 있지 않습니다."
    exit 1
fi
echo "      Docker 정상 실행 중"

# reset 모드: 볼륨 삭제
if [ "$MODE" = "reset" ]; then
    echo ""
    echo "[경고] 완전 초기화를 선택하셨습니다."
    echo "       모든 데이터베이스 데이터가 삭제됩니다!"
    echo ""
    read -p "정말 초기화하시겠습니까? (yes/no): " CONFIRM
    if [ "$CONFIRM" != "yes" ]; then
        echo "취소되었습니다."
        exit 0
    fi
    echo ""
    echo "[2/6] 기존 서비스 및 데이터 삭제 중..."
    docker-compose down -v 2>/dev/null || true
    docker rmi {project}-api:latest {project}-frontend:latest 2>/dev/null || true
    echo "      삭제 완료"
elif [ "$MODE" = "update" ]; then
    echo ""
    echo "[2/6] 기존 서비스 중지 및 이미지 교체 준비 중..."
    docker-compose down 2>/dev/null || true
    docker rmi {project}-api:latest {project}-frontend:latest 2>/dev/null || true
    echo "      준비 완료"
else
    echo ""
    echo "[2/6] 기존 설치 확인 중..."
fi

# .env 파일 확인 (이미 기본값으로 포함되어 있어야 함)
echo ""
echo "[3/6] 환경 설정 파일 확인 중..."
if [ ! -f "$SCRIPT_DIR/.env" ]; then
    echo "[오류] .env 파일을 찾을 수 없습니다."
    echo "       설치 파일이 손상되었을 수 있습니다."
    exit 1
fi
echo "      .env 파일 확인 완료"

# 이미지 로드
echo ""
echo "[4/6] Docker 이미지 로드 중..."
if [ -f "$SCRIPT_DIR/{project}-all.tar" ]; then
    if ! docker image inspect {project}-api:latest > /dev/null 2>&1; then
        echo "      이미지 로드 중... (잠시 기다려주세요)"
        docker load -i "$SCRIPT_DIR/{project}-all.tar"
        echo "      이미지 로드 완료"
    else
        if [ "$MODE" = "install" ]; then
            echo "      이미지가 이미 존재합니다."
            echo "      업데이트가 필요하면 './install.sh update'를 실행하세요."
        else
            echo "      새 이미지 로드 완료"
        fi
    fi
else
    echo "[오류] {project}-all.tar 파일을 찾을 수 없습니다."
    exit 1
fi

# 베이스 이미지 다운로드
echo ""
echo "[5/6] 필수 이미지 확인 중..."
docker image inspect mysql:8.0 > /dev/null 2>&1 || docker pull mysql:8.0
docker image inspect redis:7-alpine > /dev/null 2>&1 || docker pull redis:7-alpine
echo "      완료"

# 서비스 시작
echo ""
echo "[6/6] 서비스 시작 중..."
docker-compose up -d

echo ""
echo "============================================"
case "$MODE" in
    update) echo "  업데이트 완료!" ;;
    reset)  echo "  초기화 완료!" ;;
    *)      echo "  설치 완료!" ;;
esac
echo "============================================"
echo ""
echo "  서비스 상태:"
docker-compose ps
echo ""
echo "  잠시 후 서비스가 준비됩니다... (10초)"
sleep 10

echo ""
echo "============================================"
echo "  접속 정보"
echo "============================================"
echo ""
echo "  웹: http://localhost:8960"
echo "  API: http://localhost:8950/docs"
echo "  DB: localhost:3310"
echo ""
echo "============================================"
echo "  명령어"
echo "============================================"
echo ""
echo "  로그 보기:     docker-compose logs -f"
echo "  서비스 중지:   docker-compose down"
echo "  서비스 재시작: docker-compose restart"
echo "  업데이트:      ./install.sh update"
echo "  완전 초기화:   ./install.sh reset"
echo ""
```

#### docker-images/update.sh

```bash
#!/bin/bash
# 소스코드 업데이트 (DB 데이터 유지)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$SCRIPT_DIR/install.sh" update
```

#### docker-images/reset.sh

```bash
#!/bin/bash
# 완전 초기화 (모든 데이터 삭제)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$SCRIPT_DIR/install.sh" reset
```

#### docker-images/logs.sh

```bash
#!/bin/bash
# 실시간 로그 보기
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
docker-compose logs -f
```

#### docker-images/cleanup.sh

```bash
#!/bin/bash
# Docker 리소스 정리

echo ""
echo "============================================"
echo "  Docker 리소스 정리"
echo "============================================"
echo ""

echo "[1/3] 중지된 컨테이너 삭제..."
docker container prune -f

echo ""
echo "[2/3] 사용하지 않는 이미지 삭제..."
docker image prune -f

echo ""
echo "[3/3] 사용하지 않는 볼륨 삭제..."
docker volume prune -f

echo ""
echo "정리 완료!"
```

---

#### docker-images/.env

배포 패키지에 기본값이 포함된 .env 파일:

```env
# {Project} Docker Configuration
# 필요시 이 파일을 수정하여 설정을 변경할 수 있습니다.

# Port Configuration (사용자 입력값 반영)
FRONTEND_PORT={user_frontend_port}    # 웹 브라우저 접속 (필수)
API_PORT={user_backend_port}          # Swagger, API 테스트 (개발용)
DB_PORT={user_db_port}                # HeidiSQL 접속 (개발용)

# Database Configuration
DB_NAME={project}_db
DB_USER=root
DB_PASSWORD=password123

# Security
SECRET_KEY={project}-default-secret-key

# External API Keys (Optional)
MFDS_SERVICE_KEY=
```

#### .gitignore 추가 항목

```gitignore
# Docker deployment (tar 이미지만 제외, 나머지는 포함)
docker-images/*.tar
{project}-docker-deploy.zip
```

### 6. 배포 ZIP 생성

모든 파일 생성 후 안내:

```
배포 패키지 생성 방법:
1. docker-build-images.bat 실행
2. PowerShell에서:
   Compress-Archive -Path 'docker-images/*' -DestinationPath '{project}-docker-deploy.zip'
```

### 7. 소스코드 업데이트 배포 절차

사용자에게 안내할 업데이트 배포 절차:

```
[개발 PC]
1. 소스코드 수정
2. docker-build-images.bat 실행 → 새 이미지 빌드
3. ZIP 파일 재생성 → {project}-docker-deploy.zip
4. 배포 PC로 전송

[배포 PC]
1. 새 ZIP 파일 압축 해제 (기존 폴더 덮어쓰기)
2. update.bat 더블클릭 (또는 install.bat update 실행)
   → 기존 이미지 삭제
   → 새 이미지 로드
   → 서비스 재시작
   → DB 데이터는 유지됨
```

### 8. 완료 메시지

생성 완료 후 출력:

```
Docker 배포 환경이 구성되었습니다.

생성된 파일:
- backend/Dockerfile (멀티스테이지, 보안 최적화, 소스보호: {protection_type})
- frontend/Dockerfile (멀티스테이지, 헬스체크)
- frontend/nginx.conf
- docker-compose.yml (개발용)
- docker-compose.prod.yml (프로덕션 오버라이드)
- docker-build-images.bat/.sh (이미지 빌드)
- docker-images/
  - docker-compose.yml (배포용)
  - .env (기본값 포함, 바로 실행 가능)
  - install.bat/.sh (처음 설치)
  - update.bat/.sh (소스코드 업데이트)
  - reset.bat/.sh (완전 초기화)
  - logs.bat/.sh (로그 보기)
  - cleanup.bat/.sh (리소스 정리)
- .gitignore (업데이트)

포트 설정:
- Frontend: {user_frontend_port} (웹 브라우저 접속)
- Backend: {user_backend_port} (Swagger, API 테스트)
- MySQL: {user_db_port} (HeidiSQL 접속)

다음 단계:
1. docker-build-images.bat 실행하여 이미지 빌드
2. ZIP 파일 생성하여 배포

배포 PC에서 실행:

Windows (더블클릭):
- install.bat : 처음 설치
- update.bat  : 소스코드 업데이트 (DB 유지)
- reset.bat   : 완전 초기화 (데이터 삭제)
- logs.bat    : 실시간 로그 보기
- cleanup.bat : Docker 리소스 정리

Linux/Mac (터미널):
- ./install.sh, ./update.sh, ./reset.sh
- ./logs.sh, ./cleanup.sh

접속 정보:
- 웹: http://localhost:{user_frontend_port}
- API 문서: http://localhost:{user_backend_port}/docs
- DB: localhost:{user_db_port} (HeidiSQL)
```

---

## Notes

- `{project}`는 실제 프로젝트명으로 대체
- `{Project}`는 프로젝트명의 첫 글자 대문자 형태
- 기존 파일이 있으면 백업 후 덮어쓰기 여부 확인
- 프로젝트 구조에 따라 Dockerfile 내용 조정
