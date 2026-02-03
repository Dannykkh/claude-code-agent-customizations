# MEMORY.md - 프로젝트 장기기억

## 프로젝트 목표

**Claude Code를 더 똑똑하게 만드는 커스터마이징 모음**

| 목표 | 상태 |
|------|------|
| Skills 라이브러리 (재사용 가능한 워크플로우) | ✅ 완성 |
| Agents (자동화된 전문가 에이전트) | ✅ 완성 |
| Hooks (자동 검증/트리거) | ✅ 완성 |
| 장기기억 시스템 (대화 저장 + 컨텍스트 트리) | ✅ 완성 |
| PM-Worker 오케스트레이터 (병렬 작업) | ✅ 완성 |
| 설치 스크립트 (다른 프로젝트에 적용) | 🔄 진행중 |

**핵심 원칙:**
- 빠르게 (훅에서 AI 호출 금지)
- 단순하게 (파일 기반, 복잡한 DB 없음)
- 검색 가능하게 (키워드 + 컨텍스트 트리)

---

## 키워드 인덱스

| 키워드 | 섹션 |
|--------|------|
| agents, skills, passive-context | [#architecture/agents-vs-skills](#agentsvsskills) |
| 3-layer, hooks, validation | [#architecture/three-layer](#threelayer) |
| orchestrator, pm-worker, parallel | [#tools/orchestrator](#orchestrator) |
| memory, conversation, hooks, response-saving | [#architecture/long-term-memory](#longtermmemory) |
| superseded, history, decision-change | [#patterns/superseded-pattern](#supersededpattern) |
| skill-500, progressive-disclosure | [#patterns/skill-optimization](#skilloptimization) |
| naming, kebab-case | [#patterns/naming-convention](#namingconvention) |
| fullstack, spring-boot, flow, orchestration | [#architecture/fullstack-coding-standards](#fullstackcodingstandards) |

---

## architecture/

### agents-vs-skills
`tags: agents, skills, passive-context, vercel`
`date: 2026-01-31`

- **AGENTS.md**: 프레임워크 지식, 코드 생성 규칙 (패시브 = 100% 통과율)
- **Skills**: 사용자 트리거 워크플로우, 마이그레이션
- **원칙**: Retrieval-led reasoning > Pre-training knowledge
- **참조**: [2026-01-31 대화](.claude/conversations/2026-01-31.md)

### three-layer
`tags: 3-layer, hooks, validation, architecture`
`date: 2026-01-31`

1. **AGENTS.md (Passive)**: 핵심 규칙 항상 존재 → 예방
2. **Hooks (Automatic)**: 규칙 위반 자동 감지 → 검증
3. **Skills (On-demand)**: 상세 분석 필요 시 → 심화

### long-term-memory
`tags: memory, conversation, hooks, append, context-tree, response-saving`
`date: 2026-02-03`

**설계 결정 - Stop 훅 제거:**
- Before: Stop 훅에서 Claude 2번 호출 (키워드 추출 + 메모리 업데이트)
- After: Stop 훅 없음, Claude가 대화 중 직접 처리
- **이유**: 속도 개선 (훅에서 AI 호출 금지 원칙)

**설계 결정 - 응답 저장 확대:**
- Before: 코드 작성, 파일 수정 등 "실제 작업"만 저장
- After: 의미있는 대화 모두 저장 (토론, 의사결정 과정 포함)
- **이유**: "의견을 도출해나가는 과정"도 가치 있음
- **제외**: 단순 인사, 잡담만

**구현:**
- User 입력: 훅에서 자동 저장
- Assistant 응답: Claude가 직접 저장 (Edit 도구, ~100ms)
- MEMORY.md: 컨텍스트 트리 구조 (architecture/, patterns/, gotchas/)

**참조**: [2026-02-03 대화](.claude/conversations/2026-02-03.md)

### fullstack-coding-standards
`tags: agent, skill, fullstack, spring-boot, react, orchestration, flow`
`date: 2026-02-03`

**설계 결정 - 에이전트+스킬 분리:**
- Before: 단일 에이전트 484줄 (규칙+코드 예시 혼재)
- After: 에이전트(~235줄 규칙/체크리스트) + 스킬(코드 예시 + templates/)
- **이유**: 500줄 제한 준수, 패시브 에이전트는 규칙만, 상세 코드는 on-demand

**핵심 아키텍처:**
- 백엔드 4계층: Controller → Flow → Service → Repository
- Flow 항상 존재 (단순 위임도 통일성 우선)
- 프론트 Feature-based + TanStack Query 3계층
- Java/Spring Boot 12개 코딩 규칙 포함 (@Transactional, DTO 변환, 예외 처리 등)

**참조**: [2026-02-03 대화](.claude/conversations/2026-02-03.md)

---

## patterns/

### skill-optimization
`tags: skill-500, progressive-disclosure, context`
`date: 2026-01-31`

- **500줄 제한**: SKILL.md는 500줄 이하 유지
- **분리**: 상세 내용은 `templates/` 또는 `references/`로
- **예시**: docker-deploy (1,179줄 → 109줄 + templates/)

### naming-convention
`tags: naming, kebab-case, folder`
`date: 2026-01-31`

- 폴더명 = YAML frontmatter `name` 필드와 일치
- kebab-case 사용 (예: `python-backend-fastapi`)

### add-skill-workflow
`tags: skill, workflow, packaging`
`date: 2026-01-31`

1. `skills/{skill-name}/SKILL.md` 생성
2. YAML frontmatter에 `name`, `description` 필수
3. 500줄 초과 시 분리
4. `zip -r {skill-name}.zip {skill-name}/`
5. AGENTS.md, README.md 업데이트

### doc-sync
`tags: readme, documentation, sync`
`date: 2026-01-31`

- README.md ↔ README-ko.md 동기화
- AGENTS.md 수정 시 Quick Retrieval Paths 확인

### superseded-pattern
`tags: superseded, history, decision-change`
`date: 2026-02-03`

결정이 바뀌면 **삭제 금지**, 이력 보존:

```markdown
### 기존-결정 ❌ SUPERSEDED
`superseded-by: #새-결정`

### 새-결정 ✅ CURRENT
`supersedes: #기존-결정`
- **변경 이유**: ...
```

**참조**: [2026-02-03 대화](.claude/conversations/2026-02-03.md)

---

## tools/

### orchestrator
`tags: orchestrator, pm-worker, parallel, mcp`
`date: 2026-02-02`

PM + Worker 패턴의 병렬 처리:
- **위치**: `mcp-servers/claude-orchestrator-mcp/`
- **트리거**: `workpm` (PM), `pmworker` (Worker)
- **PM 도구**: `orchestrator_analyze_codebase`, `orchestrator_create_task`
- **Worker 도구**: `orchestrator_claim_task`, `orchestrator_lock_file`
- **참조**: [2026-02-02 대화](.claude/conversations/2026-02-02.md)

**설계 결정 - 에이전트 간 대화 미도입:**
- 파일 락으로 충돌 방지됨
- PM이 명확히 정의하면 대화 불필요
- 속도 > 협업 (대화 대기로 느려지면 의미 감소)

### multi-ai-tools
`tags: multi-ai, octopus, workflow, comparison`
`date: 2026-02-02`

| 도구 | 특징 | 용도 |
|------|------|------|
| Claude-Octopus | 3 AI + 자동 합성 | 아키텍처 리뷰 |
| Claude-Code-Workflow | 대시보드 | 복잡한 워크플로우 |
| myclaude | 심플 | 빠른 시작 |

---

## gotchas/

### duplication-check
`tags: duplication, skill, agent`
`date: 2026-01-31`

- 새 스킬/에이전트 추가 전 기존 항목과 중복 확인
- 예: erd-designer는 mermaid-diagrams에 포함 → 삭제됨

### context-efficiency
`tags: context, token, loading`
`date: 2026-01-31`

- Skills: on-demand 로딩 (트리거 시에만)
- AGENTS.md: 항상 로드 → 핵심만 압축
- 500줄+ 파일: 참조로 분리 (progressive disclosure)

---

## meta/

- **프로젝트**: claude-code-agent-customizations
- **생성일**: 2026-01-29
- **구조 개편**: 2026-02-03 (컨텍스트 트리 도입)
