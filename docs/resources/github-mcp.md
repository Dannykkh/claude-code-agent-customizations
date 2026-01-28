# GitHub MCP Server

> AI 도구를 GitHub 플랫폼에 직접 연결하는 MCP 서버

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/github/github-mcp-server](https://github.com/github/github-mcp-server) |
| **제작자** | GitHub |
| **라이선스** | MIT |
| **분류** | MCP 서버 |

---

## 개요

GitHub 공식 MCP 서버. 저장소 관리, 이슈/PR 자동화, CI/CD 모니터링, 코드 분석 등 GitHub의 모든 기능을 Claude에서 직접 사용할 수 있습니다.

---

## 주요 기능

### 1. 저장소 관리

| 기능 | 설명 |
|------|------|
| **코드 탐색** | 파일 검색, 구조 파악 |
| **커밋 분석** | 히스토리, 변경 사항 확인 |
| **브랜치 관리** | 생성, 삭제, 비교 |

### 2. 이슈 & PR 자동화

| 기능 | 설명 |
|------|------|
| **이슈 생성** | 버그 리포트, 기능 요청 자동 생성 |
| **이슈 업데이트** | 라벨, 담당자, 상태 변경 |
| **PR 생성** | 코드 변경 후 자동 PR |
| **PR 리뷰** | 코드 리뷰 코멘트 작성 |

### 3. CI/CD 인텔리전스

| 기능 | 설명 |
|------|------|
| **워크플로우 모니터링** | 실행 상태 확인 |
| **빌드 분석** | 실패 원인 분석 |
| **로그 조회** | 액션 로그 확인 |

### 4. 코드 분석

| 기능 | 설명 |
|------|------|
| **보안 경고** | Dependabot 알림 확인 |
| **의존성 검토** | 취약한 패키지 탐지 |
| **코드 패턴** | 코드 스캐닝 결과 확인 |

---

## 설치 방법

### 방법 1: 원격 서버 (권장)

VS Code 1.101+ 사용 시 OAuth로 바로 연결:

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.github.com/mcp"
    }
  }
}
```

### 방법 2: Claude Code CLI

```bash
claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

### 방법 3: 로컬 서버 (Docker)

```bash
# Personal Access Token 생성 필요
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_xxxx

docker run -e GITHUB_PERSONAL_ACCESS_TOKEN \
  ghcr.io/github/github-mcp-server
```

---

## 토큰 권한 설정

### 최소 권한 (읽기 전용)

```
repo (read)
issues (read)
pull_requests (read)
```

### 전체 기능 사용

```
repo (read/write)
issues (read/write)
pull_requests (read/write)
actions (read)
security_events (read)
```

---

## 사용 예시

### 이슈 생성

```
이 버그에 대한 GitHub 이슈를 생성해줘
→ 제목, 설명, 라벨 자동 설정 후 이슈 생성
```

### PR 리뷰

```
이 PR의 변경사항을 리뷰해줘
→ 코드 변경 분석 후 리뷰 코멘트 작성
```

### 빌드 실패 분석

```
왜 CI가 실패했는지 분석해줘
→ 액션 로그 확인 후 원인 분석
```

### 보안 경고 확인

```
이 저장소의 보안 취약점을 확인해줘
→ Dependabot, 코드 스캐닝 결과 조회
```

---

## 툴셋 구성

| 툴셋 | 포함 도구 |
|------|----------|
| **repos** | 저장소 정보, 파일, 커밋 |
| **issues** | 이슈 CRUD |
| **pull_requests** | PR CRUD, 리뷰 |
| **actions** | 워크플로우, 로그 |
| **code_security** | 보안 경고, 취약점 |

```json
{
  "toolsets": ["repos", "issues", "pull_requests"]
}
```

---

## 장단점

### 장점
- GitHub 공식 지원
- 모든 GitHub 기능 접근 가능
- OAuth 지원 (토큰 관리 편리)
- 다양한 설치 방식 (원격/로컬/Docker)

### 단점/주의사항
- Personal Access Token 필요
- API 레이트 리밋 적용
- 프라이빗 저장소 접근 시 권한 설정 주의

---

## 관련 리소스

- [GitHub API 문서](https://docs.github.com/en/rest)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Personal Access Token 생성](https://github.com/settings/tokens)

---

**문서 작성일:** 2026-01-28
