# Handoff: Codex Compatibility Wrap-up

## Session Metadata
- Created: 2026-03-13 01:28:26 +09:00
- Project: D:\git\claude-code-agent-customizations
- Branch: master

## Current State Summary
Claude에 추가된 skills, agents, hooks, Chronos, notify 배선을 Codex에도 반영 가능한지 점검하고 필요한 적응을 진행했다. 현재 repo 원본과 Codex 설치본의 sync는 대체로 동작하며, Codex 쪽 핵심 런타임은 `notify -> save-turn -> ddingdong-noti/continue-loop`로 정리됐다. 다만 Claude root hooks 전체가 Codex에서 자동 enforcement 되는 구조는 아니고, `~/.codex/config.toml`의 orchestrator 경로는 현재 repo가 아니라 전역 설치본을 가리키는 상태라 향후 기준 경로 결정이 필요하다.

## Work Completed
- [x] `seo-audit`, `reddit-researcher`, `ui-ux-auditor`, `video-maker`, Chronos 관련 자산의 Codex sync/설치 상태 점검
- [x] `scripts/sync-codex-assets.js`를 확장해 Codex notify hooks까지 `~/.codex/hooks`로 배포되게 정리
- [x] `skills/codex-mnemo/hooks/save-turn.*`에서 `ddingdong-noti.*`, `continue-loop.*` fan-out 배선 추가
- [x] `install.bat`/`install.sh` 출력 문구를 Codex `Skills/Agents/Hooks` 기준으로 정정
- [x] `scripts/audit-codex-compatibility.js` 추가 및 `docs/codex-compatibility-report.md` 재생성
- [x] Claude 전용 흔적이 강했던 일부 skill 문서를 Codex/Gemini fallback 기준으로 보정

### Files Modified
| File | Changes |
|------|---------|
| scripts/sync-codex-assets.js | Codex skills/agents/root hooks/notify hooks 동기화 범위 확장 |
| skills/codex-mnemo/hooks/save-turn.ps1 | notify fan-out, ddingdong-noti, Chronos resume 배선 추가 |
| skills/codex-mnemo/hooks/save-turn.sh | notify fan-out, Bash 경로/loop resume 보강 |
| skills/auto-continue-loop/SKILL.md | Codex Chronos 사용 흐름 문서화 |
| install.bat | Codex 설치 출력 문구와 sync 흐름 점검 |
| install.sh | Codex 설치 출력 문구와 sync 흐름 점검 |
| scripts/audit-codex-compatibility.js | Codex config/sync/Claude-marker audit 스크립트 추가 |
| docs/codex-compatibility-report.md | 최신 점검 결과 반영 |
| skills/command-creator/SKILL.md | Claude slash command 한정성과 Codex fallback 명시 |
| skills/daily-meeting-update/SKILL.md | Codex/Gemini 대화 로그 fallback 추가 |
| skills/manage-skills/SKILL.md | repo 기준 path/AGENTS.md 중심 설명으로 보정 |
| skills/verify-implementation/SKILL.md | path 및 AskUserQuestion fallback 보정 |
| skills/api-handoff/SKILL.md | 출력 경로를 repo 공용 docs 경로로 일반화 |

### Decisions Made
| Decision | Rationale |
|----------|-----------|
| repo 단일 원본 + CLI별 generated install 유지 | skill/agent 문서를 사람 손으로 이중 관리하면 drift가 빠르게 발생함 |
| Codex는 Claude root hook 복제가 아니라 notify orchestrator 중심으로 적응 | Codex 실행 모델은 `config.toml`의 `notify` 한 축이 핵심이라 Claude 이벤트 모델과 동일하지 않음 |
| `mnemo`는 공통 개념, `codex-mnemo`/`gemini-mnemo`는 어댑터로 해석 | 공유 메모리와 CLI별 훅/로그를 함께 설명하려면 이 구분이 가장 일관됨 |

## Pending Work
### Immediate Next Steps
1. `~/.codex/config.toml`의 `mcp_servers.orchestrator`를 현재 repo 기준으로 바꿀지, 전역 설치본을 정본으로 둘지 결정
2. Codex에서 자동 실행되지 않는 Claude root hooks를 어떤 항목까지 bridge할지 우선순위 선정
3. `mnemo` 이름을 `claude-mnemo`로 대칭 정리할지, 현재 이름을 유지하고 문서만 보강할지 결정

### Blockers/Open Questions
- [ ] orchestrator 런타임의 source of truth를 repo와 전역 설치본 중 어디로 둘지 미정
- [ ] Claude 전용 문구가 남은 나머지 skills/agents를 얼마나 적극적으로 Codex형으로 다듬을지 범위 미정

## Context for Resuming
### Important Context
현재 Codex 설치 경로의 핵심 상태는 정상이다. `~/.codex/config.toml`에는 `notify = ['pwsh', '-NoLogo', '-NoProfile', '-File', 'C:/Users/Administrator/.codex/hooks/save-turn.ps1']`가 설정돼 있고, 이 `save-turn`이 Mnemo 저장 후 ddingdong 알림과 Chronos continue-loop를 fan-out한다. 반면 root hooks는 `~/.codex/hooks`에 복사돼도 자동으로 실행되지 않으므로, “복사됨”과 “실제로 enforcement 됨”을 항상 구분해서 봐야 한다.

### Potential Gotchas
- Codex `orchestrator` MCP 경로는 현재 repo가 아니라 `C:\Users\Administrator\AppData\Roaming\TermSnap\claude-customizations\...` 전역 설치본을 가리키고 있어 repo 수정이 즉시 반영되지 않을 수 있다.
- 워크트리에 기존 dirty 변경이 많으므로 후속 작업 시 이번 세션 변경과 사용자 변경을 섞어 되돌리지 않도록 주의해야 한다.
- `mnemo` 명칭은 현재 Claude판 기본 구현처럼 보이지만 개념상은 family name에 가까워 문서화가 부족하면 다시 혼동될 수 있다.
