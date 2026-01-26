# MCP Servers

Model Context Protocol (MCP) 서버 모음 및 설정 가이드

---

## 📋 외부 MCP 서버 (권장)

### 1. Toss Payments - 결제 연동 (⭐ 추천)

[토스페이먼츠 MCP](https://toss.tech/article/tosspayments-mcp)는 PG업계 최초로 도입된 결제 연동 MCP 서버입니다.

**효과:**
- 결제 연동 시간: **3개월 → 10분**으로 단축
- 자연어 명령으로 결제 코드 생성
- 5년간 축적된 연동 가이드, API 문서, 예제 코드 학습

**설치:**

```bash
claude mcp add tosspayments -- npx -y @tosspayments/integration-guide-mcp@latest
```

**수동 설정:**

```json
{
  "mcpServers": {
    "tosspayments": {
      "command": "npx",
      "args": ["-y", "@tosspayments/integration-guide-mcp@latest"]
    }
  }
}
```

**사용법:**

```
User: 결제창을 연결해줘
User: 정기결제 연동하고 싶어
User: V2 SDK로 결제위젯 삽입하는 코드 작성해줘
User: 결제 승인 요청하는 코드를 작성해줘
```

**호환 도구:** Claude, Cursor, Cody 등

**참고:**
- [토스 기술블로그: MCP 서버 구현기](https://toss.tech/article/tosspayments-mcp)
- [토스페이먼츠 개발자센터: LLM 가이드](https://docs.tosspayments.com/guides/v2/get-started/llms-guide)
- [토스페이먼츠 블로그](https://www.tosspayments.com/blog/articles/mcp)

---

### 2. Context7 - 라이브러리 문서 검색

[Context7](https://github.com/upstash/context7)은 최신 라이브러리 문서를 LLM 컨텍스트에 직접 주입하는 MCP 서버입니다.

**기능:**
- 최신 버전의 라이브러리 문서 검색
- 공식 소스에서 코드 예제 가져오기
- 프롬프트에 "use context7" 추가만으로 동작

**설치:**

```bash
# Claude Code에 추가 (npx 방식)
claude mcp add context7 -- npx -y @upstash/context7-mcp

# 또는 HTTP 방식
claude mcp add --transport http context7 https://mcp.context7.com/mcp
```

**수동 설정** (`~/.claude/settings.json` 또는 `.claude/settings.local.json`):

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

**사용법:**

```
User: React 19의 useActionState 사용법 알려줘. use context7
Claude: [Context7 MCP로 최신 React 19 문서 검색]
```

특정 라이브러리 지정:
```
User: use library /supabase/supabase for API docs
```

**제공 도구:**
- `resolve-library-id`: 라이브러리 이름을 Context7 호환 ID로 변환
- `get-library-docs`: 라이브러리 문서 검색 (tokens 파라미터로 크기 조절)

**요구사항:** Node.js >= 18.0.0

**참고:** [Context7 공식 문서](https://github.com/upstash/context7) | [Upstash Blog](https://upstash.com/blog/context7-mcp)

---

### 3. Playwright - 브라우저 자동화

[Playwright MCP](https://github.com/microsoft/playwright-mcp)는 Microsoft에서 관리하는 공식 브라우저 자동화 MCP 서버입니다.

**기능:**
- 브라우저 창 제어 (Chrome, Firefox, WebKit)
- 웹 페이지 접근성 트리 기반 상호작용
- 스크린샷 없이 구조화된 데이터로 동작
- 세션 동안 쿠키 유지 (수동 로그인 가능)

**설치:**

```bash
# Claude Code에 추가
claude mcp add playwright -- npx -y @playwright/mcp@latest
```

**수동 설정:**

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "timeout": 60000
    }
  }
}
```

**사용법:**

```
User: playwright mcp로 https://example.com 열어서 내용 확인해줘
Claude: [Playwright MCP로 브라우저 열기]
```

**실용적인 사용 사례:**
- 웹 애플리케이션 E2E 테스트
- 웹 페이지 스크래핑
- 로그인이 필요한 사이트 자동화 (수동 로그인 후 자동화)
- UI 검증 및 디버깅

**브라우저 설치:**
첫 사용 시 자동으로 브라우저 바이너리가 설치됩니다.

**참고:** [Microsoft Playwright MCP](https://github.com/microsoft/playwright-mcp) | [Simon Willison's TIL](https://til.simonwillison.net/claude-code/playwright-mcp-claude-code)

---

### 4. Python - 코드 실행

Python 코드를 실행하고 Python 환경을 관리하는 MCP 서버입니다.

**옵션 A: mcp-server-fetch + Python 실행**

```bash
# Python 실행 서버 설치 (uvx 사용)
pip install mcp-server-python
```

**설정:**

```json
{
  "mcpServers": {
    "python": {
      "command": "uvx",
      "args": ["mcp-server-python"]
    }
  }
}
```

**옵션 B: 직접 Python 스크립트 실행**

```json
{
  "mcpServers": {
    "python-exec": {
      "command": "python",
      "args": ["-m", "mcp_server_python"],
      "env": {
        "PYTHON_EXEC_TIMEOUT": "30"
      }
    }
  }
}
```

**기능:**
- Python 코드 스니펫 실행
- Python 파일 실행
- 파일 관리 (읽기, 쓰기, 목록)
- Python 환경 정보 확인
- 타임아웃 및 작업 디렉토리 설정

**참고:** [Python MCP SDK](https://github.com/modelcontextprotocol/python-sdk) | [Code Execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp)

---

### 5. Filesystem - 파일 시스템 접근

로컬 파일 시스템에 접근하는 MCP 서버입니다.

**설치:**

```bash
claude mcp add filesystem -- npx -y @anthropic-ai/mcp-server-filesystem /path/to/allowed/dir
```

**설정:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@anthropic-ai/mcp-server-filesystem",
        "/path/to/your/projects",
        "/path/to/your/data"
      ]
    }
  }
}
```

---

### 6. GitHub - GitHub API 접근

GitHub 리포지토리, 이슈, PR 관리를 위한 MCP 서버입니다.

**설정:**

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token_here"
      }
    }
  }
}
```

---

### 7. Stitch MCP - Google Stitch UI 디자인

[Google Stitch](https://stitch.withgoogle.com/)와 연동하여 AI 기반 UI/UX 디자인을 생성하는 MCP 서버입니다.

**기능:**
- AI 기반 UI 화면 생성
- 프로젝트 및 스크린 관리
- 프론트엔드 코드 및 디자인 시스템 추출
- 2024-2025 UI 트렌드 적용 (glassmorphism, bento-grid, gradient-mesh 등)

**설치 (자동 설정):**

```bash
# 자동 설치 - Claude Code, Gemini CLI, Codex CLI에 자동 설정
npx -p stitch-mcp-auto stitch-mcp-auto-setup
```

**수동 설정:**

```json
{
  "mcpServers": {
    "stitch": {
      "command": "npx",
      "args": ["-y", "stitch-mcp"]
    }
  }
}
```

또는 David East 버전:

```json
{
  "mcpServers": {
    "stitch": {
      "command": "npx",
      "args": ["-y", "@_davideast/stitch-mcp"]
    }
  }
}
```

**사용법:**

```
User: /stitch:design 홈 화면 디자인해줘
User: /stitch:design-system 현재 프로젝트의 디자인 시스템 추출해줘
User: /stitch:design-flow 로그인 → 대시보드 플로우 생성해줘
```

**제공 명령:**
- `/stitch:design` - UI 화면 디자인 생성
- `/stitch:design-system` - 디자인 시스템 추출
- `/stitch:design-flow` - 화면 플로우 생성
- `/stitch:design-qa` - 디자인 QA
- `/stitch:design-export` - 코드 내보내기

**참고:** [stitch-mcp GitHub](https://github.com/Kargatharaakash/stitch-mcp) | [davideast/stitch-mcp](https://github.com/davideast/stitch-mcp) | [Google Stitch Docs](https://stitch.withgoogle.com/docs/mcp/setup)

---

### 8. Canva MCP - 디자인 & 프레젠테이션 (⭐ 추천)

[Canva MCP](https://www.canva.com/help/mcp-agent-setup/)는 Canva 공식 MCP 서버로, AI 어시스턴트에서 직접 디자인을 생성하고 관리할 수 있습니다.

**기능:**
- Canva AI로 디자인 생성
- 템플릿 자동 채우기 (Autofill)
- 기존 디자인 검색 및 수정
- PDF/이미지로 내보내기
- 브랜드 일관성 유지

**설치:**

Canva 개발자 포털에서 API 키 발급 후:

```bash
claude mcp add canva -- npx -y @canva/mcp-server
```

**수동 설정:**

```json
{
  "mcpServers": {
    "canva": {
      "command": "npx",
      "args": ["-y", "@canva/mcp-server"],
      "env": {
        "CANVA_API_KEY": "your_canva_api_key"
      }
    }
  }
}
```

**사용법:**

```
User: Canva로 마케팅 프레젠테이션 만들어줘
User: 이 데이터로 인포그래픽 생성해줘
User: 내 브랜드 스타일로 소셜 미디어 포스트 만들어줘
```

**참고:** [Canva MCP Setup Guide](https://www.canva.com/help/mcp-agent-setup/) | [Canva Dev MCP Docs](https://www.canva.dev/docs/apps/mcp-server/)

---

### 9. PowerPoint MCP - PPT 자동화

[PowerPoint MCP](https://github.com/socamalo/PPT_MCP_Server)는 Microsoft PowerPoint를 직접 제어하는 MCP 서버입니다.

**기능:**
- 프레젠테이션 생성 및 수정
- 슬라이드 추가/삭제/편집
- 텍스트, 이미지, 차트 삽입
- 네이티브 .pptx 파일 생성

**설치:**

```bash
# Python 패키지 설치
pip install ppt-mcp-server

# 또는 직접 클론
git clone https://github.com/socamalo/PPT_MCP_Server
cd PPT_MCP_Server
pip install -r requirements.txt
```

**설정:**

```json
{
  "mcpServers": {
    "powerpoint": {
      "command": "python",
      "args": ["-m", "ppt_mcp_server"]
    }
  }
}
```

**사용법:**

```
User: 분기별 실적 보고서 PPT 만들어줘
User: 이 슬라이드에 차트 추가해줘
User: 회사 템플릿으로 프레젠테이션 생성해줘
```

**참고:** [PPT MCP Server GitHub](https://github.com/socamalo/PPT_MCP_Server) | [Playbooks.com Guide](https://playbooks.com/mcp/socamalo-powerpoint)

---

### 10. Google Slides MCP - 슬라이드 자동화

[Google Slides MCP](https://github.com/matteoantoci/google-slides-mcp)는 Google Slides API를 통해 프레젠테이션을 생성하고 수정하는 MCP 서버입니다.

**기능:**
- 프레젠테이션 생성 (`create_presentation`)
- 프레젠테이션 조회 (`get_presentation`)
- 배치 업데이트 (`batch_update_presentation`)
- 텍스트, 도형, 이미지, 슬라이드 추가

**설치:**

```bash
# npm 방식
npm install -g google-slides-mcp
```

**설정:**

Google Cloud Console에서 OAuth 자격증명 설정 후:

```json
{
  "mcpServers": {
    "google-slides": {
      "command": "npx",
      "args": ["-y", "google-slides-mcp"],
      "env": {
        "GOOGLE_CLIENT_ID": "your_client_id",
        "GOOGLE_CLIENT_SECRET": "your_client_secret"
      }
    }
  }
}
```

**사용법:**

```
User: Google Slides로 새 프레젠테이션 만들어줘
User: 이 마크다운 내용으로 슬라이드 생성해줘
User: 기존 프레젠테이션에 새 슬라이드 추가해줘
```

**참고:** [google-slides-mcp GitHub](https://github.com/matteoantoci/google-slides-mcp) | [Zapier Google Slides MCP](https://zapier.com/mcp/google-slides)

---

### 11. SlideSpeak MCP - AI 프레젠테이션 생성

[SlideSpeak MCP](https://slidespeak.co/blog/2025/07/21/create-ai-presentations-in-claude-using-mcp)는 전문적인 PowerPoint 프레젠테이션을 AI로 생성하는 리모트 MCP 서비스입니다.

**기능:**
- 자연어로 PPT 생성
- 전문 디자인 템플릿 적용
- 네이티브 .pptx 파일 출력
- 복잡한 설정 없이 바로 사용

**설치:**

```bash
claude mcp add slidespeak -- npx -y @slidespeak/mcp
```

**설정:**

```json
{
  "mcpServers": {
    "slidespeak": {
      "command": "npx",
      "args": ["-y", "@slidespeak/mcp"],
      "env": {
        "SLIDESPEAK_API_KEY": "your_api_key"
      }
    }
  }
}
```

**사용법:**

```
User: "AI 트렌드 2026" 주제로 10장짜리 프레젠테이션 만들어줘
User: 이 보고서 내용을 PPT로 변환해줘
User: 투자자 피칭 덱 만들어줘
```

**참고:** [SlideSpeak MCP Blog](https://slidespeak.co/blog/2025/07/21/create-ai-presentations-in-claude-using-mcp)

---

### 12. Plus AI MCP - 고급 프레젠테이션

[Plus AI MCP](https://plusai.com/features/mcp)는 커스텀 템플릿과 고급 슬라이드 요소(차트, 이미지)를 지원하는 프레젠테이션 생성 MCP입니다.

**기능:**
- 네이티브 PowerPoint/Google Slides 생성
- 커스텀 템플릿 지원
- 차트, 그래프, 이미지 자동 생성
- 기존 워크플로우에 쉽게 통합

**특징:**
다른 AI 프레젠테이션 도구와 달리 **네이티브 슬라이드**를 생성하여 바로 편집 가능

**설정:**

```json
{
  "mcpServers": {
    "plusai": {
      "command": "npx",
      "args": ["-y", "@plusai/mcp-server"],
      "env": {
        "PLUSAI_API_KEY": "your_api_key"
      }
    }
  }
}
```

**참고:** [Plus AI MCP](https://plusai.com/features/mcp)

---

### 13. FlashDocs MCP - 범용 문서/슬라이드 생성

[FlashDocs MCP](https://www.flashdocs.com/post/flashdocs-model-context-protocol-mcp)는 AI가 구조화된 방식으로 슬라이드 덱을 생성할 수 있게 해주는 MCP 서버입니다.

**기능:**
- PowerPoint, Google Slides, PDF 출력
- 메타데이터, 슬라이드 의도, 콘텐츠 블록, 레이아웃 힌트 지정
- AI 에이전트/앱에서 바로 사용 가능

**설정:**

```json
{
  "mcpServers": {
    "flashdocs": {
      "command": "npx",
      "args": ["-y", "@flashdocs/mcp"],
      "env": {
        "FLASHDOCS_API_KEY": "your_api_key"
      }
    }
  }
}
```

**사용법:**

```
User: 이 내용으로 발표 자료 만들어줘 (PowerPoint로)
User: 팀 회의용 슬라이드 PDF로 생성해줘
```

**참고:** [FlashDocs MCP](https://www.flashdocs.com/post/flashdocs-model-context-protocol-mcp)

---

## 📦 포함된 커스텀 MCP 서버

### claude-orchestrator-mcp

Claude Code의 다중 에이전트 오케스트레이션을 위한 MCP 서버입니다.

**기능:**
- PM (Project Manager) 모드: 작업을 여러 에이전트로 분할
- Worker 모드: 개별 작업 실행
- 병렬 실행: 여러 에이전트가 동시에 작업 수행
- 작업 추적: 각 에이전트의 진행 상황 모니터링

**아키텍처:**
```
Main Claude (PM)
    ↓
┌───┴───┬───────┬───────┐
│       │       │       │
Agent1  Agent2  Agent3  Agent4
(분석)  (코딩)  (테스트) (리팩토링)

→ 복잡한 작업을 여러 에이전트가 병렬로 처리
```

**설치 및 설정:**

1. **의존성 설치:**
```bash
cd mcp-servers/claude-orchestrator-mcp
npm install
```

2. **빌드:**
```bash
npm run build
```

3. **Claude Code 설정 파일에 추가:**
```json
{
  "mcpServers": {
    "orchestrator": {
      "command": "node",
      "args": [
        "/path/to/claude-code-customizations/mcp-servers/claude-orchestrator-mcp/dist/index.js"
      ]
    }
  }
}
```

**제공하는 MCP 도구:**
- `orchestrate_agents`: PM 모드로 작업 분할 및 에이전트 오케스트레이션
- `execute_task`: Worker 모드로 개별 작업 실행
- `list_agents`: 현재 실행 중인 에이전트 목록 조회

---


## ⚡ 빠른 설정 (권장 조합)

모든 권장 MCP 서버를 한 번에 설정하려면 다음을 `.claude/settings.local.json`에 추가:

```json
{
  "mcpServers": {
    "tosspayments": {
      "command": "npx",
      "args": ["-y", "@tosspayments/integration-guide-mcp@latest"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "timeout": 60000
    },
    "stitch": {
      "command": "npx",
      "args": ["-y", "stitch-mcp"]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@anthropic-ai/mcp-server-filesystem",
        "/path/to/your/projects"
      ]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token"
      }
    }
  }
}
```

### CLI로 빠르게 추가하기

```bash
# Toss Payments - 결제 연동 (10분 완료)
claude mcp add tosspayments -- npx -y @tosspayments/integration-guide-mcp@latest

# Context7 - 라이브러리 문서
claude mcp add context7 -- npx -y @upstash/context7-mcp

# Playwright - 브라우저 자동화
claude mcp add playwright -- npx -y @playwright/mcp@latest

# Stitch - UI 디자인 (자동 설정)
npx -p stitch-mcp-auto stitch-mcp-auto-setup

# Canva - 디자인 & 프레젠테이션
claude mcp add canva -- npx -y @canva/mcp-server

# SlideSpeak - AI PPT 생성
claude mcp add slidespeak -- npx -y @slidespeak/mcp

# GitHub
claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

---

## 🔧 MCP 서버 개발 가이드

### 새 MCP 서버 만들기

1. **프로젝트 초기화:**
```bash
mkdir my-mcp-server
cd my-mcp-server
npm init -y
npm install @modelcontextprotocol/sdk zod
npm install -D typescript @types/node
```

2. **TypeScript 설정** (`tsconfig.json`):
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true
  }
}
```

3. **MCP 서버 코드** (`src/index.ts`):
```typescript
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';

const server = new Server({
  name: 'my-mcp-server',
  version: '1.0.0'
}, {
  capabilities: {
    tools: {}
  }
});

// 도구 등록
server.setRequestHandler('tools/list', async () => ({
  tools: [{
    name: 'my_tool',
    description: 'My custom tool',
    inputSchema: {
      type: 'object',
      properties: {
        param: { type: 'string' }
      }
    }
  }]
}));

server.setRequestHandler('tools/call', async (request) => {
  return { content: [{ type: 'text', text: 'Result' }] };
});

const transport = new StdioServerTransport();
await server.connect(transport);
```

4. **빌드 및 Claude Code에 추가:**
```bash
npm run build
```

---

## 🐛 트러블슈팅

### MCP 서버가 시작되지 않음

```bash
# 로그 확인
claude --verbose

# MCP 서버 직접 실행하여 에러 확인
npx -y @upstash/context7-mcp
```

### 도구가 Claude에게 표시되지 않음

1. Claude Code 재시작
2. MCP 서버 설정 확인 (`settings.json`)
3. `/mcp` 명령으로 MCP 상태 확인

### npx 실행 오류

```bash
# npm 캐시 정리
npm cache clean --force

# Node.js 버전 확인 (>= 18 필요)
node --version
```

### 타임아웃 오류

설정에 `timeout` 값 추가:
```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["..."],
      "timeout": 60000
    }
  }
}
```

---

## 📚 참고 자료

- [Model Context Protocol Specification](https://modelcontextprotocol.io/)
- [MCP SDK Documentation](https://github.com/anthropics/mcp)
- [Claude Code MCP Integration](https://code.claude.com/docs/en/mcp)
- [Context7 MCP](https://github.com/upstash/context7)
- [Playwright MCP](https://github.com/microsoft/playwright-mcp)
- [Python MCP SDK](https://github.com/modelcontextprotocol/python-sdk)

---

**버전:** 2.1.0
**최종 업데이트:** 2026-01-26
