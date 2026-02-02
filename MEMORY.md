# MEMORY.md - 프로젝트 장기기억

이 파일은 Claude Code가 세션 간에 기억해야 할 정보를 저장합니다.
새 세션마다 자동으로 로드됩니다.

---

## 프로젝트 컨텍스트

- 프로젝트: claude-code-agent-customizations
- 생성일: 2026-01-29

## 중요한 결정사항

### AGENTS.md vs Skills 전략 (2026-01-31)

Vercel 연구 결과에 따른 설계 결정:
- **AGENTS.md**: 프레임워크 지식, 코드 생성 규칙 (패시브 컨텍스트 = 100% 통과율)
- **Skills**: 사용자 트리거 워크플로우, 버전 마이그레이션, 아키텍처 변경

핵심 원칙: "Retrieval-led reasoning > Pre-training knowledge"
- 로컬 문서가 존재하면 학습 데이터보다 우선 참조
- 압축된 인덱스 형식으로 컨텍스트 효율성 극대화 (40KB → 8KB로 80% 압축해도 100% 유지)

## 학습된 교훈

### SKILL.md 컨텍스트 최적화 (2026-01-31)

- **500줄 제한**: SKILL.md는 500줄 이하 유지
- **Progressive Disclosure**: 상세 내용은 `templates/` 또는 `references/` 폴더로 분리
- **예시**: docker-deploy 스킬 리팩토링 (1,179줄 → 109줄 + templates/)

### 네이밍 컨벤션 (2026-01-31)

- 폴더명 = YAML frontmatter의 `name` 필드와 일치해야 함
- kebab-case 사용 (예: `python-backend-fastapi`, `vercel-react-best-practices`)

### 3중 레이어 아키텍처 (2026-01-31)

Vercel 연구 기반 3중 레이어 구조 도입:
1. **AGENTS.md (Passive)**: 핵심 규칙이 항상 컨텍스트에 존재 → 예방
2. **Hooks (Automatic)**: 규칙 위반 자동 감지 → 검증
3. **Skills (On-demand)**: 상세 분석 필요 시 → 심화

### 가이드라인 vs 워크플로우 분리 (2026-01-31)

Skills 중 "순수 가이드라인"은 Agents로 이동:
- react-best-practices, python-fastapi-guidelines, writing-guidelines 등
- 항상 적용되어야 할 규칙 → auto_apply: true

Skills 중 "워크플로우/액션"은 유지:
- docker-deploy, code-reviewer (실행 로직), naming-analyzer (분석)
- 사용자 트리거 필요

## 작업 패턴

### 새 스킬 추가 워크플로우
1. `skills/{skill-name}/SKILL.md` 생성
2. YAML frontmatter에 `name`, `description` 필수
3. 500줄 초과 시 `templates/` 또는 `references/` 분리
4. `zip -r {skill-name}.zip {skill-name}/` 패키징
5. AGENTS.md, README.md 업데이트

### 문서 동기화
- README.md (영문) 수정 시 README-ko.md (한국어)도 함께 업데이트
- AGENTS.md 수정 시 Quick Retrieval Paths 테이블 확인

## MCP 서버

### claude-orchestrator-mcp (2026-02-02)

PM + Worker 패턴의 병렬 처리 오케스트레이터:
- **위치**: `mcp-servers/claude-orchestrator-mcp/`
- **설정**: `.claude/settings.local.json`에 등록됨
- **실행**: `.\scripts\launch.ps1 -ProjectPath "경로"`
- **용도**: 대규모 리팩토링, 모듈별 병렬 작업

핵심 도구:
- PM: `orchestrator_analyze_codebase`, `orchestrator_create_task`
- Worker: `orchestrator_claim_task`, `orchestrator_lock_file`, `orchestrator_complete_task`

### 멀티 AI 오케스트레이션 도구 (2026-02-02)

외부 도구 비교 분석 결과:
| 도구 | 특징 | 추천 용도 |
|------|------|----------|
| Claude-Octopus | 3 AI 동시 + 자동 합성 | 아키텍처 리뷰 |
| Claude-Code-Workflow | 가장 풍부, 대시보드 | 복잡한 워크플로우 |
| myclaude | 심플 설치 | 빠른 시작 |

스킬 `multi-ai-orchestration` 추가됨 - 설정 및 사용 가이드 포함

## 장기기억 시스템 (2026-02-02)

### 구성 요소
- **에이전트**: `agents/memory-writer.md` - 세션 종료 시 대화 분석 및 MEMORY.md 자동 업데이트
- **스킬**: `skills/long-term-memory/` - 수동 기억 추가/조회 기능

### 사용 방법
- 기억 추가: `"이거 기억해: ..."` 또는 `/memory add ...`
- 기억 조회: `"...에 대해 뭘 기억해?"` 또는 `/memory search ...`
- 전체 보기: `"장기기억 보여줘"` 또는 `/memory list`

### 자동 기록 대상
- 아키텍처/설계 결정
- 버그 원인과 해결 방법
- 기술 스택 선택 이유
- 반복되는 작업 패턴
- 주의해야 할 함정/이슈

## 주의사항

### 중복 방지
- 새 스킬/에이전트 추가 전 기존 항목과 중복 확인
- 예시: erd-designer는 mermaid-diagrams에 포함됨 → 삭제됨

### 컨텍스트 효율성
- Skills는 on-demand 로딩 (트리거 시에만 SKILL.md 로드)
- AGENTS.md는 항상 로드됨 → 핵심 정보만 압축하여 포함
- 큰 파일(500줄+)은 참조 파일로 분리하여 progressive disclosure 적용

---
*이 파일은 TermSnap에서 자동 생성되었습니다. 자유롭게 수정하세요.*
