# MEMORY.md - 프로젝트 장기기억

컨텍스트 트리 구조의 장기기억 저장소입니다.
키워드로 검색하거나, 트리 구조로 탐색할 수 있습니다.

---

## 키워드 인덱스

| 키워드 | 섹션 |
|--------|------|
| agents, skills, passive-context | [#architecture/agents-vs-skills](#agentsvsskills) |
| 3-layer, hooks, validation | [#architecture/three-layer](#threelayer) |
| orchestrator, pm-worker, parallel | [#tools/orchestrator](#orchestrator) |
| memory, conversation, hooks | [#architecture/long-term-memory](#longtermmemory) |
| skill-500, progressive-disclosure | [#patterns/skill-optimization](#skilloptimization) |
| naming, kebab-case | [#patterns/naming-convention](#namingconvention) |

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
`tags: memory, conversation, hooks, append`
`date: 2026-02-03`

- **저장**: 대화 로그 단순 append (AI 호출 없음, 빠름)
- **키워드**: 해시태그(#keyword) 자동 추출
- **업데이트**: Claude가 대화 중 판단하여 MEMORY.md 직접 수정
- **구조**: 컨텍스트 트리 + 키워드 인덱스
- **참조**: [2026-02-03 대화](.claude/conversations/2026-02-03.md)

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
