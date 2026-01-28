# awesome-claude-code-subagents

> 126개 이상의 전문화된 Claude Code 서브에이전트 컬렉션

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) |
| **제작자** | VoltAgent |
| **라이선스** | MIT |
| **분류** | Agent 컬렉션 |
| **에이전트 수** | 126+ |

---

## 개요

개발 작업의 모든 단계를 위한 전문 서브에이전트들의 완전한 생태계. 10개 카테고리로 분류된 126개 이상의 에이전트를 제공합니다.

---

## 카테고리별 에이전트

### 1. 핵심 개발 - `voltagent-core-dev`

백엔드, 프론트엔드, 풀스택 작업:

| 에이전트 | 전문 분야 |
|---------|----------|
| `api-designer` | API 설계 |
| `backend-developer` | 백엔드 개발 |
| `frontend-developer` | 프론트엔드 개발 |
| `fullstack-developer` | 풀스택 개발 |
| `electron-pro` | Electron 앱 |
| `websocket-engineer` | 실시간 통신 |
| `wordpress-master` | WordPress |

### 2. 언어 전문가 - `voltagent-lang`

프로그래밍 언어/프레임워크별 심화:

| 분류 | 에이전트 |
|------|---------|
| **웹** | TypeScript, JavaScript, PHP, Laravel |
| **백엔드** | Python, Django, Java, Spring Boot, Go, Rust |
| **모바일** | Swift, Kotlin, Flutter, React Native |
| **프레임워크** | React, Vue, Angular, Next.js, NestJS |
| **.NET** | C#, .NET Core |
| **기타** | C++, Rails |

### 3. 인프라/DevOps - `voltagent-infra`

배포 및 운영:

| 에이전트 | 전문 분야 |
|---------|----------|
| `kubernetes-specialist` | K8s 오케스트레이션 |
| `terraform-engineer` | IaC |
| `devops-engineer` | CI/CD |
| `cloud-architect` | 클라우드 설계 |
| `sre-engineer` | 사이트 신뢰성 |
| `database-administrator` | DB 관리 |
| `azure-infra-engineer` | Azure |
| `windows-infra-admin` | Windows 서버 |

### 4. 품질 & 보안 - `voltagent-qa-sec`

테스트 및 보안:

| 에이전트 | 전문 분야 |
|---------|----------|
| `code-reviewer` | 코드 리뷰 |
| `qa-expert` | QA 전반 |
| `penetration-tester` | 침투 테스트 |
| `security-auditor` | 보안 감사 |
| `performance-engineer` | 성능 최적화 |
| `accessibility-tester` | 접근성 테스트 |

### 5. 데이터 & AI - `voltagent-data-ai`

데이터 처리 및 ML:

| 에이전트 | 전문 분야 |
|---------|----------|
| `data-engineer` | 데이터 파이프라인 |
| `data-scientist` | 분석 및 모델링 |
| `machine-learning-engineer` | ML 엔지니어링 |
| `ai-engineer` | AI 시스템 |
| `nlp-engineer` | 자연어 처리 |
| `prompt-engineer` | 프롬프트 엔지니어링 |
| `postgres-pro` | PostgreSQL 전문가 |

### 6. 개발자 경험 - `voltagent-dev-exp`

생산성 도구:

| 에이전트 | 전문 분야 |
|---------|----------|
| `documentation-engineer` | 문서화 |
| `legacy-modernizer` | 레거시 현대화 |
| `refactoring-specialist` | 리팩토링 |
| `git-workflow-manager` | Git 워크플로우 |
| `cli-developer` | CLI 도구 |
| `mcp-developer` | MCP 개발 |

### 7. 전문 분야 - `voltagent-domains`

특화 기술:

| 에이전트 | 전문 분야 |
|---------|----------|
| `blockchain-developer` | 블록체인 |
| `game-developer` | 게임 개발 |
| `iot-engineer` | IoT |
| `fintech-engineer` | 핀테크 |
| `m365-admin` | Microsoft 365 |
| `payment-integration` | 결제 연동 |
| `seo-specialist` | SEO |

### 8. 비즈니스 & 제품 - `voltagent-biz`

관리 및 전략:

| 에이전트 | 전문 분야 |
|---------|----------|
| `product-manager` | 제품 관리 |
| `project-manager` | 프로젝트 관리 |
| `business-analyst` | 비즈니스 분석 |
| `scrum-master` | 애자일/스크럼 |
| `ux-researcher` | UX 리서치 |
| `technical-writer` | 기술 문서 |

### 9. 메타/오케스트레이션 - `voltagent-meta`

멀티에이전트 조정:

| 에이전트 | 전문 분야 |
|---------|----------|
| `agent-installer` | 에이전트 설치 |
| `multi-agent-coordinator` | 다중 에이전트 조율 |
| `workflow-orchestrator` | 워크플로우 조율 |
| `context-manager` | 컨텍스트 관리 |
| `performance-monitor` | 성능 모니터링 |

### 10. 연구 & 분석 - `voltagent-research`

정보 수집:

| 에이전트 | 전문 분야 |
|---------|----------|
| `research-analyst` | 연구 분석 |
| `search-specialist` | 검색 전문 |
| `trend-analyst` | 트렌드 분석 |
| `market-researcher` | 시장 조사 |

---

## 설치 방법

### 카테고리별 설치 (권장)

```bash
# 언어 전문가
claude plugin install voltagent-lang

# 인프라/DevOps
claude plugin install voltagent-infra

# 품질 & 보안
claude plugin install voltagent-qa-sec

# 데이터 & AI
claude plugin install voltagent-data-ai
```

### 대화형 설치기

```bash
git clone https://github.com/VoltAgent/awesome-claude-code-subagents.git
cd awesome-claude-code-subagents
./install-agents.sh
```

### 개별 에이전트 설치

```bash
# 특정 에이전트만 복사
cp agents/kubernetes-specialist.md ~/.claude/agents/
```

---

## 사용 예시

### K8s 배포

```
이 앱을 Kubernetes에 배포해줘
→ kubernetes-specialist 활성화
```

### 보안 감사

```
이 코드의 보안 취약점을 검사해줘
→ security-auditor 활성화
```

### 데이터 파이프라인

```
ETL 파이프라인을 설계해줘
→ data-engineer 활성화
```

---

## 장단점

### 장점
- 126개 이상 에이전트로 모든 분야 커버
- 카테고리별 모듈 설치
- 각 에이전트가 독립적 컨텍스트 보유
- 팀 간 공유 가능

### 단점/주의사항
- 모든 에이전트 설치 시 컨텍스트 과다
- 필요한 카테고리만 선택적 설치 권장

---

## 관련 리소스

- [Claude Code Subagents 문서](https://docs.anthropic.com/claude-code/subagents)
- [oh-my-claudecode](./oh-my-claudecode.md) - 유사한 에이전트 컬렉션

---

**문서 작성일:** 2026-01-28
