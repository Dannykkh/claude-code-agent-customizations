# Claude Code 커스터마이징

Claude Code를 위한 커스텀 Skills, Agents, Commands, Hooks, MCP 서버 모음입니다.

**[English Version](README.md)**

---

## 왜 이 프로젝트를 만들었나?

Claude Code를 사용하면서 반복적으로 겪는 문제들이 있었습니다:
- 새 프로젝트마다 같은 설정을 반복
- 유용한 외부 스킬과 플러그인을 매번 검색
- 비슷한 에이전트 프롬프트를 반복 작성

이 저장소는 다음 문제들을 해결합니다:
1. **설정 중앙화** - 모든 커스터마이징을 한 곳에서 관리
2. **외부 리소스 문서화** - 유용한 스킬, 플러그인, MCP 서버 큐레이션
3. **프로젝트 유형별 템플릿** - 기술 스택별 빠른 설정 가이드

---

## 빠른 시작

> **새 환경 설정?** [SETUP.md](SETUP.md)에서 프로젝트 유형별 상세 설치 가이드를 확인하세요.

### 프로젝트 유형별 설치

| 프로젝트 유형 | 설치 명령 |
|-------------|---------|
| **WPF / WinForms** | `npx add-skill Aaronontheweb/claude-code-dotnet -a claude-code` |
| **React / Next.js** | `npx add-skill vercel-labs/agent-skills -a claude-code` |
| **Node.js / NestJS** | `npx add-skill SpillwaveSolutions/mastering-typescript-skill -a claude-code` |
| **결제 연동** | `claude mcp add tosspayments -- npx -y @tosspayments/integration-guide-mcp@latest` |

### 전체 설치

```bash
# Windows
install.bat

# Linux/Mac
chmod +x install.sh && ./install.sh
```

---

## 포함된 내용

### 커스텀 스킬 (슬래시 명령어)

| 스킬 | 명령어 | 기술/기능 | 설명 |
|------|--------|----------|------|
| **docker-deploy** | `/docker-deploy` | Docker, docker-compose, Cython/PyArmor | Dockerfile (멀티스테이지), docker-compose.yml, 설치 스크립트(bat/sh) 자동 생성. Python 소스코드 보호 지원 |
| **code-reviewer** | `/code-reviewer` | Python, TypeScript | 자동 코드 리뷰: 500줄 파일 제한, 50줄 함수 제한, 보안 취약점(SQL Injection, XSS), 타입 힌트, SRP/DRY 원칙 |
| **react-best-practices** | `/react-best-practices` | React, Next.js | Vercel의 45개 최적화 규칙: 워터폴 제거, 번들 크기, 서버사이드 성능, 리렌더 최적화 |
| **web-design-guidelines** | `/web-design-guidelines` | 접근성, UX | Web Interface Guidelines 기반 UI 준수 검토 (a11y, 사용성) |
| **python-backend** | `/python-backend` | FastAPI, Pydantic, SQLAlchemy | Python 백엔드 모범 사례: 비동기 프로그래밍, 리포지토리 패턴, 서비스 레이어, 의존성 주입 |
| **api-tester** | `/api-tester` | CORS, JWT, Proxy | 프론트엔드-백엔드 통합 테스트: 프록시 설정, 토큰 검증, 에러 응답 포맷 |
| **erd-designer** | `/erd-designer` | Mermaid | Mermaid 형식 ERD 다이어그램 생성 |
| **humanizer** | `/humanizer` | Writing | AI가 쓴 티 나는 글을 자연스럽게 수정. Wikipedia "Signs of AI writing" 기반 (24개 패턴) |
| **ppt-generator** | `/ppt-generator` | python-pptx, PowerPoint | 템플릿 기반 전문 PPT 생성. 마크다운/JSON 입력, 차트/표/이미지 지원 |

### 커스텀 에이전트 (서브에이전트)

| 에이전트 | 기술 스택 | 설명 |
|---------|----------|------|
| **frontend-react** | React 18+, TypeScript, TanStack Query, Zustand, Tailwind CSS, Shadcn/UI | React 컴포넌트 분석, 상태 관리 (서버: React Query / 클라이언트: Zustand), Atomic Design 패턴 |
| **backend-spring** | Java 21, Spring Boot 3.x, Spring Security, JPA/Hibernate, Redis | Clean Architecture, DDD, OpenAPI 3.0 기반 RESTful API 설계 |
| **database-mysql** | MySQL 8.0, Flyway | 스키마 설계, 쿼리 최적화, 인덱싱 전략, 멀티테넌트 아키텍처 |
| **ai-ml** | Python 3.11, FastAPI, LangChain, Claude/OpenAI API, Milvus/Qdrant | LLM 통합, RAG 검색 시스템, 문서 분석, 임베딩 서비스 |
| **api-tester** | curl, REST/GraphQL | API 엔드포인트 테스트, 인증 테스트, 응답 검증 |
| **code-reviewer** | - | 코드 품질(SRP, DRY), 보안 취약점, 성능 검토 |
| **qa-engineer** | JUnit, Jest, pytest, Playwright, Cypress, k6 | 테스트 전략, 품질 검증, 회귀 테스트 |
| **qa-writer** | - | 테스트 시나리오 작성 (Smoke/Functional/Regression/Edge Case/Performance) |
| **documentation** | - | PRD, API 문서(OpenAPI), IMPLEMENTATION.md, CHANGELOG, ADR 템플릿 |
| **migration-helper** | - | 레거시(Template + jQuery) → 모던(REST API + React SPA) 마이그레이션 패턴 |
| **explore-agent** | - | 신규 기능 구현 전 레거시 코드 분석 |
| **feature-tracker** | - | 프로젝트 기능 진행률 추적 및 시각화 |
| **api-comparator** | - | 레거시 vs 신규 API 호환성 검증, 마이그레이션 타임라인 계획 |

### 명령어 & 스크립트

| 명령어 | 설명 |
|--------|------|
| `/check-todos` | TODO 항목 검토 및 우선순위 분류 |
| `/write-api-docs` | API 문서 자동 생성 |
| `/write-changelog` | Git 커밋 기반 Changelog 자동 생성 |
| `/write-prd` | PRD (제품 요구사항 문서) 작성 |
| `/test` | 테스트 실행 및 커버리지 보고서 |
| `/review` | 코드 리뷰 수행 |
| `/migrate` | 마이그레이션 작업 실행 |
| `/generate` | 코드 템플릿 생성 |
| `/daily-sync` | 일일 동기화 및 상태 확인 |
| `/update-docs` | 문서 파일 업데이트 |

### 훅

| 훅 | 타이밍 | 설명 |
|----|--------|------|
| protect-files.sh | PreToolUse | 중요 파일 수정 전 보호 검사 |
| format-code.sh | PostToolUse | 파일 수정 후 코드 포맷팅 |
| validate-api.sh | PostToolUse | API 파일 수정 후 유효성 검사 |

---

## 외부 리소스 (권장)

> **[상세 문서 보기](docs/resources/)** - 각 리소스별 기능, 설치, 사용법, 장단점 정리

### 스킬 & 플러그인

| 리소스 | 설명 | 설치 | 문서 |
|--------|------|------|------|
| [everything-claude-code](https://github.com/affaan-m/everything-claude-code) | 해커톤 우승자 설정 (12 에이전트, 16 스킬) | `/plugin marketplace add affaan-m/everything-claude-code` | [상세](docs/resources/everything-claude-code.md) |
| [Vercel Agent Skills](https://github.com/vercel-labs/agent-skills) | React/Next.js 베스트 프랙티스 (45+ 규칙) | `npx add-skill vercel-labs/agent-skills -a claude-code` | [상세](docs/resources/vercel-agent-skills.md) |
| [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) | 32개 에이전트, 40+ 스킬, 다중 에이전트 오케스트레이션 | `/plugin install oh-my-claudecode` | [상세](docs/resources/oh-my-claudecode.md) |
| [claude-code-dotnet](https://github.com/Aaronontheweb/claude-code-dotnet) | C#/WPF/MAUI/.NET 스킬 | `npx add-skill Aaronontheweb/claude-code-dotnet -a claude-code` | - |
| [mastering-typescript-skill](https://github.com/SpillwaveSolutions/mastering-typescript-skill) | 엔터프라이즈 TypeScript (NestJS, React 19) | `npx add-skill SpillwaveSolutions/mastering-typescript-skill -a claude-code` | - |
| [pg-aiguide](https://github.com/timescale/pg-aiguide) | PostgreSQL 베스트 프랙티스 | `claude plugin install pg-aiguide` | - |
| [skills.sh](https://skills.sh/) | 25K+ 스킬 디렉토리 (Vercel) | `npx skills add <owner/repo>` | [상세](docs/resources/skills-sh.md) |

### MCP 서버

| MCP | 설명 | 설치 | 문서 |
|-----|------|------|------|
| **[토스페이먼츠](https://toss.tech/article/tosspayments-mcp)** | 결제 연동 10분 완료 (PG업계 최초) | `claude mcp add tosspayments -- npx -y @tosspayments/integration-guide-mcp@latest` | [상세](docs/resources/toss-payments-mcp.md) |
| [Context7](https://github.com/upstash/context7) | 라이브러리 문서 검색 | `claude mcp add context7 -- npx -y @upstash/context7-mcp` | [상세](docs/resources/context7-mcp.md) |
| [Playwright](https://github.com/microsoft/playwright-mcp) | 브라우저 자동화 | `claude mcp add playwright -- npx -y @playwright/mcp@latest` | - |
| [Stitch](https://github.com/anthropics/stitch-mcp) | Google Stitch UI 디자인 | `npx -p stitch-mcp-auto stitch-mcp-auto-setup` | - |
| [GitHub](https://github.com/github/github-mcp-server) | GitHub API 접근 | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` | - |

**무료 & 로컬 실행 (API 키 불필요):**

| MCP | 설명 | 설치 |
|-----|------|------|
| **[Office-PowerPoint-MCP](https://github.com/GongRzhe/Office-PowerPoint-MCP-Server)** | PPT 자동화 (32개 도구, 25개 템플릿) | `pip install office-powerpoint-mcp-server` |
| [mcp-pandoc](https://github.com/vivekVells/mcp-pandoc) | 문서 변환 (MD→PDF/DOCX) | `pip install mcp-pandoc` |
| [manim-mcp](https://github.com/abhiemj/manim-mcp-server) | 수학/교육 애니메이션 | Manim + 로컬 서버 |
| [blender-mcp](https://github.com/ahujasid/blender-mcp) | 3D 모델링 & 애니메이션 | Blender + 로컬 서버 |

---

## 프로젝트 구조

```
claude-code-customizations/
├── skills/                    # 커스텀 스킬 (슬래시 명령어)
│   ├── docker-deploy/         # Docker 배포 (Cython/PyArmor 지원)
│   ├── code-reviewer/         # 자동 코드 리뷰 (500줄 제한, 보안)
│   ├── react-best-practices/  # Vercel의 45개 React 최적화 규칙
│   ├── web-design-guidelines/ # UI/UX 접근성 검토
│   ├── api-tester/            # 프론트-백엔드 통합 테스트
│   ├── erd-designer/          # Mermaid ERD 생성
│   ├── humanizer/             # AI 글쓰기 패턴 제거 (24개 패턴)
│   ├── ppt-generator/         # 템플릿 기반 PPT 생성
│   └── python-backend/        # FastAPI 모범 사례
├── agents/                    # 커스텀 서브에이전트
│   ├── frontend-react.md      # React + Zustand + TanStack Query
│   ├── backend-spring.md      # Java 21 + Spring Boot 3.x
│   ├── database-mysql.md      # MySQL 8.0 + Flyway
│   ├── ai-ml.md               # LLM + RAG + Vector DB
│   ├── api-tester.md          # REST/GraphQL API 테스트
│   ├── code-reviewer.md       # 코드 품질 및 보안 검토
│   ├── qa-engineer.md         # 테스트 전략 및 실행
│   ├── qa-writer.md           # 테스트 케이스 작성
│   ├── documentation.md       # PRD, API 문서, CHANGELOG
│   ├── migration-helper.md    # 레거시 → 모던 마이그레이션
│   ├── explore-agent.md       # 레거시 코드 분석
│   ├── feature-tracker.md     # 기능 진행률 추적
│   └── api-comparator.md      # API 호환성 검증
├── commands/                  # 슬래시 명령어 & 스크립트
│   ├── check-todos.md
│   ├── write-api-docs.md
│   ├── write-changelog.md
│   ├── write-prd.md
│   ├── test.md
│   ├── review.md
│   ├── migrate.md
│   ├── generate.md
│   ├── daily-sync.md
│   └── update-docs.md
├── hooks/                     # 훅 스크립트
│   ├── protect-files.sh
│   ├── format-code.sh
│   └── validate-api.sh
├── mcp-servers/               # MCP 서버 가이드
│   ├── README.md
│   └── claude-orchestrator-mcp/
├── docs/                      # 문서
│   └── resources/             # 외부 리소스 상세 문서
│       ├── README.md          # 리소스 인덱스
│       ├── _template.md       # 새 문서 템플릿
│       ├── everything-claude-code.md
│       ├── vercel-agent-skills.md
│       ├── oh-my-claudecode.md
│       ├── skills-sh.md
│       ├── toss-payments-mcp.md
│       └── context7-mcp.md
├── install.bat                # Windows 설치 스크립트
├── install.sh                 # Linux/Mac 설치 스크립트
├── SETUP.md                   # 전체 설정 가이드
├── README.md                  # 영문 버전
└── README-ko.md               # 한국어 버전 (이 파일)
```

---

## 설치 위치

| 항목 | 글로벌 위치 | 프로젝트 위치 |
|------|------------|--------------|
| Skills | `~/.claude/skills/` | `.claude/skills/` |
| Agents | `~/.claude/agents/` | `.claude/agents/` |
| Commands | - | `.claude/commands/` |
| Hooks | `~/.claude/settings.json` | `.claude/settings.json` |

- **글로벌**: 모든 프로젝트에서 사용 가능
- **프로젝트**: 해당 프로젝트에서만 사용

---

## 새 커스터마이징 추가하기

### 새 스킬 추가
```bash
mkdir skills/my-skill
# skills/my-skill/SKILL.md 파일 작성
```

### 새 에이전트 추가
```bash
# agents/my-agent.md 파일 작성
```

### 새 명령어 추가
```bash
# commands/my-command.md 파일 작성
```

---

## 참고 리소스

### 스킬 디렉토리

| 리소스 | 설명 | 링크 |
|--------|------|------|
| **skills.sh** | Vercel의 25K+ 스킬 디렉토리 (설치: `npx skills add <owner/repo>`) | [skills.sh](https://skills.sh/) |

**인기 스킬 (설치 수 기준):**
| 스킬 | 설치 수 | 설명 |
|------|--------|------|
| vercel-react-best-practices | 50.3K | React 개발 가이드 |
| web-design-guidelines | 38.2K | 웹 디자인 원칙 |
| remotion-best-practices | 34.4K | Remotion 비디오 프레임워크 |
| frontend-design | 15.3K | 프론트엔드 아키텍처 |
| supabase-postgres-best-practices | 4.4K | 데이터베이스 패턴 |

### 커뮤니티 프로젝트

| 프로젝트 | 설명 | 링크 |
|---------|------|------|
| awesome-claude-code-subagents | 100+ 전문 서브에이전트 | [GitHub](https://github.com/VoltAgent/awesome-claude-code-subagents) |
| awesome-claude-skills | Claude 스킬 큐레이션 | [GitHub](https://github.com/travisvn/awesome-claude-skills) |
| everything-claude-code | Anthropic 해커톤 우승자 설정 | [GitHub](https://github.com/affaan-m/everything-claude-code) |
| claude-code-showcase | 종합 설정 예제 | [GitHub](https://github.com/ChrisWiles/claude-code-showcase) |
| awesome-claude-code | Claude Code 리소스 큐레이션 | [GitHub](https://github.com/hesreallyhim/awesome-claude-code) |

---

## 라이선스

MIT License

---

**최종 업데이트:** 2026-01-26
