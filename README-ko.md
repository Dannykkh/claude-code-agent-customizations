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

| 스킬 | 명령어 | 설명 |
|------|--------|------|
| docker-deploy | `/docker-deploy` | Docker 배포 환경 자동 구성 |
| code-reviewer | `/code-reviewer` | 코드 리뷰 및 규제 준수 검사 |
| react-best-practices | `/react-best-practices` | React 성능 최적화 규칙 |
| web-design-guidelines | `/web-design-guidelines` | 웹 UI 접근성 및 UX 검토 |

### 커스텀 에이전트 (서브에이전트)

| 에이전트 | 설명 |
|---------|------|
| api-tester | API 엔드포인트 테스트 및 연동 확인 |
| code-reviewer | 코드 품질, 보안, 성능 검토 |
| frontend-react | React 컴포넌트 분석 및 최적화 |
| qa-engineer | QA 검증 및 회귀 테스트 |
| qa-writer | 테스트 시나리오 및 테스트 케이스 작성 |
| documentation | 기술 문서 자동 생성 |
| migration-helper | 레거시 → 모던 스택 마이그레이션 가이드 |

### 명령어 & 스크립트

| 명령어 | 설명 |
|--------|------|
| `/check-todos` | TODO 항목 검토 및 우선순위 분류 |
| `/write-api-docs` | API 문서 자동 생성 |
| `/write-changelog` | Git 커밋 기반 Changelog 자동 생성 |
| `/write-prd` | PRD (제품 요구사항 문서) 작성 |
| `/test` | 테스트 실행 및 커버리지 보고서 |
| `/review` | 코드 리뷰 수행 |

### 훅

| 훅 | 타이밍 | 설명 |
|----|--------|------|
| protect-files.sh | PreToolUse | 중요 파일 수정 전 보호 검사 |
| format-code.sh | PostToolUse | 파일 수정 후 코드 포맷팅 |
| validate-api.sh | PostToolUse | API 파일 수정 후 유효성 검사 |

---

## 외부 리소스 (권장)

### 스킬 & 플러그인

| 리소스 | 설명 | 설치 |
|--------|------|------|
| [Vercel Agent Skills](https://github.com/vercel-labs/agent-skills) | React/Next.js 베스트 프랙티스 (45+ 규칙) | `npx add-skill vercel-labs/agent-skills -a claude-code` |
| [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) | 32개 에이전트, 40+ 스킬, 다중 에이전트 오케스트레이션 | `/plugin install oh-my-claudecode` |
| [claude-code-dotnet](https://github.com/Aaronontheweb/claude-code-dotnet) | C#/WPF/MAUI/.NET 스킬 | `npx add-skill Aaronontheweb/claude-code-dotnet -a claude-code` |
| [mastering-typescript-skill](https://github.com/SpillwaveSolutions/mastering-typescript-skill) | 엔터프라이즈 TypeScript (NestJS, React 19) | `npx add-skill SpillwaveSolutions/mastering-typescript-skill -a claude-code` |
| [pg-aiguide](https://github.com/timescale/pg-aiguide) | PostgreSQL 베스트 프랙티스 | `claude plugin install pg-aiguide` |

### MCP 서버

| MCP | 설명 | 설치 |
|-----|------|------|
| **[토스페이먼츠](https://toss.tech/article/tosspayments-mcp)** | 결제 연동 10분 완료 (PG업계 최초) | `claude mcp add tosspayments -- npx -y @tosspayments/integration-guide-mcp@latest` |
| [Context7](https://github.com/upstash/context7) | 라이브러리 문서 검색 | `claude mcp add context7 -- npx -y @upstash/context7-mcp` |
| [Playwright](https://github.com/microsoft/playwright-mcp) | 브라우저 자동화 | `claude mcp add playwright -- npx -y @playwright/mcp@latest` |
| [Stitch](https://github.com/anthropics/stitch-mcp) | Google Stitch UI 디자인 | `npx -p stitch-mcp-auto stitch-mcp-auto-setup` |
| [GitHub](https://github.com/github/github-mcp-server) | GitHub API 접근 | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |

---

## 프로젝트 구조

```
claude-code-customizations/
├── skills/                    # 커스텀 스킬 (슬래시 명령어)
│   ├── docker-deploy/
│   ├── code-reviewer/
│   ├── react-best-practices/
│   ├── web-design-guidelines/
│   ├── api-tester/
│   ├── erd-designer/
│   └── python-backend/
├── agents/                    # 커스텀 서브에이전트
│   ├── api-tester.md
│   ├── code-reviewer.md
│   ├── frontend-react.md
│   ├── qa-engineer.md
│   ├── qa-writer.md
│   ├── documentation.md
│   └── migration-helper.md
├── commands/                  # 슬래시 명령어 & 스크립트
│   ├── check-todos.md
│   ├── write-api-docs.md
│   ├── write-changelog.md
│   ├── write-prd.md
│   ├── test.md
│   └── review.md
├── hooks/                     # 훅 스크립트
│   ├── protect-files.sh
│   ├── format-code.sh
│   └── validate-api.sh
├── mcp-servers/               # MCP 서버 가이드
│   ├── README.md
│   └── claude-orchestrator-mcp/
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

**최종 업데이트:** 2026-01-25
