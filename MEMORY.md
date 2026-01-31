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

### 장기기억 시스템 구조 (2026-02-01)

세션 간 컨텍스트 유지를 위한 3단계 메모리 시스템:

**구성요소:**
| 구성요소 | 파일 | 역할 |
|---------|------|------|
| 저장소 | `MEMORY.md` | 구조화된 장기기억 (이 파일) |
| 규칙 | `CLAUDE.md` | Claude에게 메모리 기록 지시 |
| 대화 로그 | `hooks/save-conversation.sh` | 원시 대화 백업 (.claude/conversations/) |
| 자동 정리 | `hooks/update-memory.sh` | Stop 훅 → memory-writer 호출 |
| 정리 에이전트 | `agents/memory-writer.md` | 대화 분석 → MEMORY.md 작성 |
| 핸드오프 | `skills/session-handoff/` | 구조화된 세션 인수인계 문서 |

**작동 흐름:**
```
세션 중
├── [자동] UserPromptSubmit → save-conversation.sh → .claude/conversations/날짜.md
└── [수동] Claude가 중요한 결정 시 → MEMORY.md 직접 추가

세션 종료
└── [자동] Stop 훅 → update-memory.sh → memory-writer → MEMORY.md 정리

수동 백업 (Stop 훅 놓쳤을 때)
├── "메모리에 정리해줘" → memory-writer 에이전트 호출
└── /session-handoff → 구조화된 핸드오프 문서 생성
```

**핵심 원칙:**
- 대화 로그는 항상 저장 (데이터 손실 방지)
- 정리는 에이전트가 담당 (LLM 필요)
- Stop 훅 놓쳐도 수동 복구 가능

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
