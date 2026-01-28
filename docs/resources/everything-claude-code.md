# everything-claude-code

> Anthropic x Forum Ventures 해커톤 우승자의 Claude Code 설정 모음

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| **제작자** | [@affaanmustafa](https://x.com/affaanmustafa) |
| **라이선스** | MIT |
| **특징** | 해커톤 우승 검증, 프로덕션 레벨 설정 |

---

## 개요

10개월간 Claude Code를 일일 사용하며 검증된 설정 모음집. 에이전트, 스킬, 훅, 명령어, MCP 구성을 포함하며, [zenith.chat](https://zenith.chat) 프로젝트로 해커톤 우승.

**핵심 철학:**
- 컨텍스트 창 관리가 최우선 (200k → MCP 과다 시 70k로 감소)
- Hook은 100% 실행 vs Skill은 50~80% 확률
- 병렬 처리로 효율성 극대화 (`/fork`, Git Worktree)

---

## 주요 구성 요소

### 1. Agents (서브에이전트) - 12개

| 에이전트 | 파일 | 용도 |
|---------|------|------|
| Planner | `planner.md` | 기능 구현 계획 수립 |
| Architect | `architect.md` | 시스템 설계 결정 |
| TDD Guide | `tdd-guide.md` | 테스트 우선 개발 (80%+ 커버리지) |
| Code Reviewer | `code-reviewer.md` | 코드 품질/보안 리뷰 |
| Security Reviewer | `security-reviewer.md` | 보안 취약점 분석 |
| Build Error Resolver | `build-error-resolver.md` | 빌드 에러 해결 |
| E2E Runner | `e2e-runner.md` | Playwright E2E 테스트 |
| Refactor Cleaner | `refactor-cleaner.md` | 데드 코드 제거 |
| Doc Updater | `doc-updater.md` | 문서 동기화 |
| Database Reviewer | `database-reviewer.md` | DB 스키마 리뷰 |
| Go Reviewer | `go-reviewer.md` | Go 코드 리뷰 |
| Go Build Resolver | `go-build-resolver.md` | Go 빌드 에러 해결 |

### 2. Skills (스킬) - 16개

| 스킬 | 설명 |
|------|------|
| **continuous-learning-v2** | Hook 기반 자동 학습 시스템 (Instinct 모델) |
| **tdd-workflow** | TDD Red-Green-Refactor 워크플로우 |
| **iterative-retrieval** | 반복적 검색 패턴 |
| **security-review** | 보안 검토 체크리스트 |
| **coding-standards** | 코딩 표준 가이드 |
| **eval-harness** | 평가 하네스 |
| **strategic-compact** | 전략적 컴팩션 |
| **verification-loop** | 검증 루프 |
| **golang-patterns** | Go 언어 패턴 |
| **golang-testing** | Go 테스팅 |
| **frontend-patterns** | 프론트엔드 패턴 |
| **backend-patterns** | 백엔드 패턴 |
| **postgres-patterns** | PostgreSQL 패턴 |
| **clickhouse-io** | ClickHouse I/O |
| **project-guidelines-example** | 프로젝트 가이드라인 예제 |

### 3. Commands (슬래시 명령어) - 23개

| 명령어 | 용도 |
|--------|------|
| `/tdd` | TDD 워크플로우 실행 |
| `/plan` | 기능 계획 수립 |
| `/code-review` | 코드 리뷰 |
| `/verify` | 검증 루프 |
| `/orchestrate` | 태스크 오케스트레이션 |
| `/skill-create` | Git 히스토리에서 스킬 자동 생성 |
| `/instinct-status` | 학습된 Instinct 확인 |
| `/instinct-export` | Instinct 내보내기 |
| `/instinct-import` | Instinct 가져오기 |
| `/evolve` | Instinct를 스킬로 진화 |
| `/learn` | 학습 실행 |
| `/build-fix` | 빌드 에러 수정 |
| `/e2e` | E2E 테스트 실행 |
| `/eval` | 평가 실행 |
| `/test-coverage` | 테스트 커버리지 확인 |
| `/refactor-clean` | 리팩토링 및 클린업 |
| `/update-docs` | 문서 업데이트 |
| `/update-codemaps` | 코드맵 업데이트 |
| `/checkpoint` | 체크포인트 생성 |
| `/setup-pm` | 패키지 매니저 설정 |
| `/go-build`, `/go-test`, `/go-review` | Go 전용 명령어 |

---

## 핵심 기능: continuous-learning-v2

Hook 기반 자동 학습 시스템으로 세션에서 패턴을 학습.

### 아키텍처

```
세션 활동 → Hook 캡처 (100% 신뢰)
     ↓
observations.jsonl (프롬프트, 도구 호출, 결과)
     ↓
Observer Agent (Haiku, 백그라운드)
     ↓
패턴 감지: 사용자 수정, 에러 해결, 반복 워크플로우
     ↓
Instinct 생성 (신뢰도 0.3~0.9)
     ↓
/evolve로 클러스터링 → 스킬/명령어/에이전트로 진화
```

### Instinct 모델

```yaml
---
id: prefer-functional-style
trigger: "when writing new functions"
confidence: 0.7
domain: "code-style"
source: "session-observation"
---

# Prefer Functional Style

## Action
적절한 경우 클래스보다 함수형 패턴 사용

## Evidence
- 5개 인스턴스에서 함수형 패턴 선호 관찰
- 2025-01-15에 클래스 기반 → 함수형으로 수정
```

### 신뢰도 스코어링

| 점수 | 의미 | 동작 |
|------|------|------|
| 0.3 | 잠정적 | 제안만, 강제 안함 |
| 0.5 | 보통 | 관련 시 적용 |
| 0.7 | 강함 | 자동 승인 |
| 0.9 | 거의 확실 | 핵심 동작 |

---

## Hooks 설정

### 주요 Hook 패턴

```json
{
  "PreToolUse": [
    {
      "matcher": "dev server 명령",
      "action": "tmux 없이 실행 차단"
    },
    {
      "matcher": "Write && .md 파일",
      "action": "README/CLAUDE.md 외 생성 차단"
    },
    {
      "matcher": "git push",
      "action": "리뷰 알림"
    }
  ],
  "PostToolUse": [
    {
      "matcher": "Edit && .ts/.tsx/.js/.jsx",
      "action": "Prettier 자동 실행"
    },
    {
      "matcher": "Edit && .ts/.tsx",
      "action": "tsc --noEmit 타입 체크"
    },
    {
      "matcher": "Edit",
      "action": "console.log 경고"
    }
  ],
  "SessionStart": [
    { "action": "이전 컨텍스트 로드" },
    { "action": "패키지 매니저 감지" }
  ],
  "SessionEnd": [
    { "action": "세션 상태 저장" },
    { "action": "학습 패턴 추출" }
  ]
}
```

---

## 설치 방법

### 플러그인 설치 (권장)

```bash
/plugin marketplace add affaan-m/everything-claude-code
```

### 수동 설치

```bash
git clone https://github.com/affaan-m/everything-claude-code
cp -r agents skills commands hooks rules ~/.claude/
```

### 디렉토리 구조

```
~/.claude/
├── agents/           # 서브에이전트
├── skills/           # 스킬
├── commands/         # 슬래시 명령어
├── rules/            # 규칙 (.md)
├── hooks/            # hooks.json
└── homunculus/       # continuous-learning-v2 데이터
    ├── identity.json
    ├── observations.jsonl
    ├── instincts/
    │   ├── personal/
    │   └── inherited/
    └── evolved/
        ├── agents/
        ├── skills/
        └── commands/
```

---

## 핵심 팁 & 베스트 프랙티스

### 1. 컨텍스트 창 관리

```
MCP 20~30개 설치 → 10개 이하만 활성화
도구 80개 미만 유지
```

### 2. 병렬 처리

```bash
# 대화 분기
/fork

# Git Worktree로 겹치는 작업 병렬화
git worktree add ../feature-branch feature-branch
```

### 3. tmux 필수

```bash
# 장시간 명령어는 tmux에서 실행
tmux new -s dev
# Claude가 명령 실행, 로그 접근 가능

tmux attach -t dev
```

### 4. 키보드 단축키

| 단축키 | 기능 |
|--------|------|
| `Ctrl+U` | 전체 라인 삭제 |
| `!` | 빠른 bash 명령어 |
| `@` | 파일 검색 |
| `/` | 슬래시 명령어 |
| `Shift+Enter` | 멀티라인 입력 |
| `Tab` | Thinking 표시 토글 |
| `Esc Esc` | 중단 / 코드 복원 |

---

## 참고 가이드

| 가이드 | 내용 |
|--------|------|
| [the-shortform-guide.md](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md) | 설정, 기초, 철학 (필독) |
| [the-longform-guide.md](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md) | 토큰 최적화, 메모리 지속성, 평가, 병렬화 |

---

## 관련 리소스

- [zenith.chat](https://zenith.chat) - 해커톤 우승 프로젝트
- [Skill Creator GitHub App](https://github.com/apps/skill-creator) - 자동 PR, 팀 공유
- [Homunculus](https://github.com/humanplane/homunculus) - v2 아키텍처 영감

---

**문서 작성일:** 2026-01-28
