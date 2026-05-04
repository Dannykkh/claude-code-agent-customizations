# Handoff: 파이프라인 아키텍처 + 크로스-CLI 동기화

## Session Metadata
- Created: 2026-03-13 14:00
- Project: D:\git\claude-code-agent-customizations
- Branch: master

## Current State Summary
파이프라인 아키텍처(감리 분리, 다이달로스 명명, 공정도면, 코드리뷰 게이트)를 확립하고, 큐패신저 서버 자동실행 + 제우스 Docker 환경 구성을 추가했습니다. 문서 동기화(AGENTS/README/QUICK-REFERENCE/smart-setup-registry) 완료. 크로스-CLI 동기화 점검 결과 install.bat 재실행 필요.

## Work Completed
- [x] argos 독립 스킬 생성 (감리 = verify-protocol 분리)
- [x] workpm → daedalus 별칭 통일
- [x] 코드리뷰 게이트 (workpm, agent-team, workpm-mcp)
- [x] 공정도면 (zephermine Step 15.5, workpm Phase 1.5/2.5)
- [x] qpassenger 6단계 (Step 3: 서버 자동실행 + 포트 kill)
- [x] zeus Phase 2.7 (Docker Setup + 포트 충돌 해결)
- [x] 문서 동기화 5개 파일 (AGENTS/README/README-ko/QUICK-REFERENCE/smart-setup-registry)
- [x] install-select.js 기본값 all로 변경
- [x] MEMORY.md + architecture.md 업데이트

### Files Modified
| File | Changes |
|------|---------|
| skills/argos/ | 신규 생성 (감리/검증 스킬) |
| skills/qpassenger/SKILL.md | 5단계→6단계, Step 3 서버자동실행 |
| skills/zeus/SKILL.md | Phase 2.5/2.7 추가, Docker Setup |
| skills/workpm/SKILL.md | daedalus 트리거, 네이티브/MCP 분리 |
| skills/zephermine/SKILL.md | verify-protocol 제거, argos 위임 |
| skills/agent-team/SKILL.md | Step 4.5 코드리뷰 게이트 |
| skills/orchestrator/ | daedalus 트리거, workpm/workpm-mcp 코드리뷰 게이트 |
| AGENTS.md, README.md, README-ko.md | 84개, argos/daedalus 추가 |
| QUICK-REFERENCE.md | 고정 호출명 + 로컬 리소스 테이블 |
| docs/smart-setup-registry.json | argos 추가 |
| install-select.js | 기본값 all |

### Decisions Made
| Decision | Rationale |
|----------|-----------|
| 감리(argos) 분리 | 설계사≠감리 원칙, 이해충돌 방지 |
| 다이달로스 vs MCP 유지 | 네이티브 기본, --mcp 대규모 모드 |
| 다이달로스 docker-deploy 안 함 | 시공과 배포 분리, 제우스가 테스트 전에 담당 |
| memory 폴더 통합 포기 | 비용 대비 이점 부족, 현상 유지 |
| install-select 기본값 all | 다른 PC에서 Codex/Gemini 누락 방지 |

## Pending Work
### Immediate Next Steps
1. **Codex 스킬 발견 문제 해결** — `~/.codex/instructions.md` 생성 또는 AGENTS.md에 스킬 목록 추가하여 Codex AI가 스킬 존재를 인식하도록
2. **install.bat 재실행** — 현재 변경사항을 3개 CLI 글로벌에 반영
3. **git commit** — 이번 세션 변경사항 커밋

### Blockers/Open Questions
- [ ] Codex CLI가 `~/.codex/skills/` SKILL.md를 자동 발견하는지, instructions.md에 명시해야 하는지 확인 필요
- [ ] Codex config.toml의 orchestrator 경로가 TermSnap을 가리키는 문제 (install.bat 재실행으로 해결 가능)

## Context for Resuming
### Important Context
- 파이프라인: `/zephermine → /daedalus → /argos → (docker-deploy) → /qpassenger`
- 제우스는 Phase 2.7에서 docker-compose.yml 없으면 docker-deploy 스킬로 생성 + 포트 충돌 해결 + 컨테이너 실행
- 큐패신저 Step 3은 서버가 이미 떠있으면 헬스체크만 하고 skip

### Potential Gotchas
- Codex의 스킬 발견은 파일 복사만으로는 부족 — AI에게 알려주는 메커니즘 필요
- install.bat 재실행 전에는 글로벌 CLI들이 구버전 스킬을 가지고 있음
