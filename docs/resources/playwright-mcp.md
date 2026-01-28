# Playwright MCP

> LLM이 웹 브라우저를 자동화할 수 있게 하는 MCP 서버

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp) |
| **제작자** | Microsoft |
| **라이선스** | Apache 2.0 |
| **분류** | MCP 서버 |

---

## 개요

Microsoft가 제공하는 Playwright 기반 MCP 서버. 스크린샷 대신 **접근성 기반 구조 데이터**를 사용하여 비전 모델 없이도 웹 브라우저를 자동화합니다.

**핵심 특징:**
- 빠르고 경량 (픽셀 기반 입력 불필요)
- LLM 친화적 (순수 구조 데이터)
- 결정론적 도구 적용 (모호성 제거)

---

## 주요 기능

### 1. 브라우저 자동화

| 기능 | 설명 |
|------|------|
| **페이지 탐색** | URL 이동, 클릭, 입력 |
| **요소 조작** | 버튼, 폼, 링크 상호작용 |
| **데이터 추출** | 텍스트, 속성, 구조 추출 |
| **스크린샷** | 페이지/요소 캡처 |

### 2. 프로필 관리

**영구 프로필 (기본):**
- 로그인 정보 지속
- 캐시 디렉토리에 저장

**격리 모드:**
- 세션별 독립 프로필
- 종료 시 상태 소실

**브라우저 확장:**
- 기존 탭에 연결
- 로그인된 세션 활용

### 3. 브라우저 지원

- Chrome (기본)
- Firefox
- WebKit (Safari)

---

## 설치 방법

### Claude Code

```bash
claude mcp add playwright -- npx -y @playwright/mcp@latest
```

### 설정 파일

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

### 주요 옵션

```bash
# 헤드리스 모드
npx @playwright/mcp@latest --headless

# Firefox 사용
npx @playwright/mcp@latest --browser firefox

# 격리 모드
npx @playwright/mcp@latest --isolated

# 뷰포트 크기 지정
npx @playwright/mcp@latest --viewport-size 1920x1080
```

---

## 사용 예시

### 웹 스크래핑

```
example.com에서 제품 목록을 가져와줘
→ Playwright MCP가 페이지 탐색 후 데이터 추출
```

### 폼 자동화

```
이 회원가입 폼을 자동으로 채워줘
→ 폼 필드 탐지 후 입력 자동화
```

### E2E 테스트

```
로그인 → 대시보드 → 설정 페이지 흐름 테스트해줘
→ 각 단계별 자동화 및 검증
```

---

## CLI vs MCP

| 구분 | CLI + SKILLS | MCP |
|------|-------------|-----|
| **용도** | 코딩 에이전트 | 장기 실행 자동화 |
| **토큰 비용** | 낮음 | 높음 |
| **적합 케이스** | 단발성 작업 | 자체 치유 테스트 |

**권장:** 코딩 에이전트는 CLI + SKILLS, 자동화 작업은 MCP

---

## 장단점

### 장점
- Microsoft 공식 지원
- 비전 모델 불필요 (토큰 절약)
- 3대 브라우저 모두 지원
- 프로필 관리로 로그인 상태 유지

### 단점/주의사항
- 복잡한 동적 페이지는 한계 있음
- 헤드리스 모드에서 일부 사이트 차단될 수 있음
- 장시간 세션은 리소스 소비 큼

---

## 관련 리소스

- [Playwright 공식 문서](https://playwright.dev/)
- [MCP 프로토콜](https://modelcontextprotocol.io/)

---

**문서 작성일:** 2026-01-28
