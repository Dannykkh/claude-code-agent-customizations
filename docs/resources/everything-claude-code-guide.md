# everything-claude-code 단위별 사용 가이드

> 필요한 것만 골라서 추가하기

## 개요

everything-claude-code는 단일 패키지가 아닌 **개별 구성 요소들의 모음**입니다.
전체를 설치할 필요 없이, 필요한 것만 골라서 사용할 수 있습니다.

---

## 빠른 참조 표

| 구성 요소 | 추천 대상 | 복잡도 | 의존성 |
|-----------|----------|--------|--------|
| [TDD 에이전트](#1-tdd-guide-테스트-우선-개발) | 테스트 커버리지 높이고 싶은 분 | 낮음 | 없음 |
| [Code Reviewer](#2-code-reviewer-코드-리뷰) | 코드 품질 자동 검토 원하는 분 | 낮음 | 없음 |
| [Planner](#3-planner-기능-계획) | 기능 구현 전 계획 수립 | 낮음 | 없음 |
| [Security Reviewer](#4-security-reviewer-보안-검토) | 보안 취약점 검토 필요한 분 | 낮음 | 없음 |
| [Prettier Hook](#5-prettier-hook-자동-포맷팅) | JS/TS 자동 포맷팅 원하는 분 | 낮음 | Prettier |
| [TypeScript Check Hook](#6-typescript-check-hook-타입-체크) | TS 타입 에러 즉시 확인 | 낮음 | TypeScript |
| [console.log 경고 Hook](#7-consolelog-경고-hook) | console.log 실수 방지 | 낮음 | 없음 |
| [tmux 알림 Hook](#8-tmux-알림-hook) | 장시간 명령 관리 | 낮음 | tmux |
| [continuous-learning-v2](#9-continuous-learning-v2-자동-학습) | 세션에서 패턴 학습 원하는 분 | **높음** | 다수 |

---

## Agents (에이전트)

에이전트는 `~/.claude/agents/` 또는 `.claude/agents/`에 `.md` 파일로 추가합니다.

### 1. tdd-guide (테스트 우선 개발)

**용도:** 테스트 우선 개발(TDD) 방법론 강제. 80%+ 커버리지 목표.

**추천 대상:**
- 테스트 없이 코드 작성하는 습관을 고치고 싶은 분
- 프로덕션 코드 품질을 높이고 싶은 분

**핵심 기능:**
- Red-Green-Refactor 사이클 강제
- 단위/통합/E2E 테스트 가이드
- 엣지 케이스 체크리스트
- Mock 패턴 (Supabase, Redis, OpenAI)

**설치:**
```bash
# 파일 다운로드
curl -o ~/.claude/agents/tdd-guide.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/agents/tdd-guide.md
```

**사용:**
```
테스트 우선으로 검색 기능 구현해줘
→ tdd-guide 에이전트가 자동 활성화
```

---

### 2. code-reviewer (코드 리뷰)

**용도:** 코드 품질, 보안, 성능 자동 리뷰.

**추천 대상:**
- PR 전 자동 리뷰 원하는 분
- 코드 품질 기준을 유지하고 싶은 분

**핵심 기능:**
- SRP, DRY 원칙 검증
- 보안 취약점 탐지 (SQL Injection, XSS 등)
- 성능 안티패턴 감지
- 테스트 커버리지 확인

**설치:**
```bash
curl -o ~/.claude/agents/code-reviewer.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/agents/code-reviewer.md
```

**사용:**
```
이 PR 리뷰해줘
→ code-reviewer 에이전트 활성화
```

---

### 3. planner (기능 계획)

**용도:** 기능 구현 전 상세 계획 수립.

**추천 대상:**
- 바로 코딩 시작하는 대신 계획을 먼저 세우고 싶은 분
- 복잡한 기능 구현 시

**핵심 기능:**
- 요구사항 분석
- 아키텍처 결정
- 단계별 구현 계획
- 의존성 파악

**설치:**
```bash
curl -o ~/.claude/agents/planner.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/agents/planner.md
```

**사용:**
```
사용자 인증 기능 계획 세워줘
→ planner 에이전트 활성화
```

---

### 4. security-reviewer (보안 검토)

**용도:** 보안 취약점 전문 분석.

**추천 대상:**
- 보안에 민감한 코드 작성 시
- OWASP Top 10 검증 필요 시

**핵심 기능:**
- 인젝션 공격 탐지
- 인증/인가 검증
- 민감 데이터 노출 확인
- 의존성 취약점 확인

**설치:**
```bash
curl -o ~/.claude/agents/security-reviewer.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/agents/security-reviewer.md
```

---

### 5. architect (시스템 설계)

**용도:** 시스템 아키텍처 설계 및 결정.

**추천 대상:**
- 새 프로젝트 시작 시
- 대규모 리팩토링 시

**핵심 기능:**
- 아키텍처 패턴 선택 (MVC, Clean, Hexagonal 등)
- 기술 스택 결정
- 확장성/유지보수성 고려
- 트레이드오프 분석

**설치:**
```bash
curl -o ~/.claude/agents/architect.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/agents/architect.md
```

---

### 6. refactor-cleaner (리팩토링)

**용도:** 데드 코드 제거 및 코드 정리.

**추천 대상:**
- 레거시 코드 정리 시
- 불필요한 코드 제거 시

**핵심 기능:**
- 미사용 코드 탐지
- 중복 코드 제거
- 불필요한 .md 파일 정리
- 의존성 정리

**설치:**
```bash
curl -o ~/.claude/agents/refactor-cleaner.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/agents/refactor-cleaner.md
```

**사용:**
```
/refactor-clean  # 명령어로도 실행 가능
```

---

## Hooks (훅)

훅은 `~/.claude/settings.json` 또는 `.claude/settings.json`에 추가합니다.

### 5. Prettier Hook (자동 포맷팅)

**용도:** JS/TS 파일 편집 후 자동 Prettier 실행.

**추천 대상:**
- 일관된 코드 스타일 유지하고 싶은 분
- 포맷팅 실수 방지

**의존성:** `npm install -D prettier`

**설치:** `settings.json`에 추가
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "tool == \"Edit\" && tool_input.file_path matches \"\\\\.(ts|tsx|js|jsx)$\"",
        "hooks": [
          {
            "type": "command",
            "command": "node -e \"const{execSync}=require('child_process');const fs=require('fs');let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const p=i.tool_input?.file_path;if(p&&fs.existsSync(p)){try{execSync('npx prettier --write \\\"'+p+'\\\"',{stdio:['pipe','pipe','pipe']})}catch(e){}}console.log(d)})\""
          }
        ]
      }
    ]
  }
}
```

---

### 6. TypeScript Check Hook (타입 체크)

**용도:** TS 파일 편집 후 자동 타입 체크.

**추천 대상:**
- TypeScript 프로젝트
- 타입 에러 즉시 확인하고 싶은 분

**의존성:** TypeScript 프로젝트 (`tsconfig.json` 필요)

**설치:** `settings.json`에 추가
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "tool == \"Edit\" && tool_input.file_path matches \"\\\\.(ts|tsx)$\"",
        "hooks": [
          {
            "type": "command",
            "command": "node -e \"const{execSync}=require('child_process');const fs=require('fs');const path=require('path');let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const p=i.tool_input?.file_path;if(p&&fs.existsSync(p)){let dir=path.dirname(p);while(dir!==path.dirname(dir)&&!fs.existsSync(path.join(dir,'tsconfig.json'))){dir=path.dirname(dir)}if(fs.existsSync(path.join(dir,'tsconfig.json'))){try{const r=execSync('npx tsc --noEmit --pretty false 2>&1',{cwd:dir,encoding:'utf8',stdio:['pipe','pipe','pipe']});const lines=r.split('\\\\n').filter(l=>l.includes(p)).slice(0,10);if(lines.length)console.error(lines.join('\\\\n'))}catch(e){const lines=(e.stdout||'').split('\\\\n').filter(l=>l.includes(p)).slice(0,10);if(lines.length)console.error(lines.join('\\\\n'))}}}console.log(d)})\""
          }
        ]
      }
    ]
  }
}
```

---

### 7. console.log 경고 Hook

**용도:** 편집 후 console.log가 있으면 경고.

**추천 대상:**
- console.log를 커밋하는 실수를 방지하고 싶은 분

**의존성:** 없음

**설치:** `settings.json`에 추가
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "tool == \"Edit\" && tool_input.file_path matches \"\\\\.(ts|tsx|js|jsx)$\"",
        "hooks": [
          {
            "type": "command",
            "command": "node -e \"const fs=require('fs');let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const p=i.tool_input?.file_path;if(p&&fs.existsSync(p)){const c=fs.readFileSync(p,'utf8');const lines=c.split('\\\\n');const matches=[];lines.forEach((l,idx)=>{if(/console\\\\.log/.test(l))matches.push((idx+1)+': '+l.trim())});if(matches.length){console.error('[Hook] WARNING: console.log found in '+p);matches.slice(0,5).forEach(m=>console.error(m));console.error('[Hook] Remove console.log before committing')}}console.log(d)})\""
          }
        ]
      }
    ]
  }
}
```

---

### 8. tmux 알림 Hook

**용도:** 장시간 실행 명령 전 tmux 사용 알림.

**추천 대상:**
- 서버 실행, 테스트 등 장시간 명령 자주 사용하는 분
- 세션 유지가 필요한 분

**의존성:** tmux 설치 권장 (없어도 알림만 표시)

**설치:** `settings.json`에 추가
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "tool == \"Bash\" && tool_input.command matches \"(npm|pnpm|yarn|bun|cargo|pytest|vitest|playwright)\"",
        "hooks": [
          {
            "type": "command",
            "command": "node -e \"if(!process.env.TMUX){console.error('[Hook] Consider running in tmux for session persistence');console.error('[Hook] tmux new -s dev  |  tmux attach -t dev')}\""
          }
        ]
      }
    ]
  }
}
```

---

### 불필요한 .md 파일 생성 차단 Hook

**용도:** README.md, CLAUDE.md 외의 .md 파일 생성 차단.

**추천 대상:**
- 불필요한 문서 파일 생성을 방지하고 싶은 분

**설치:** `settings.json`에 추가
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "tool == \"Write\" && tool_input.file_path matches \"\\\\.(md|txt)$\" && !(tool_input.file_path matches \"README\\\\.md|CLAUDE\\\\.md|AGENTS\\\\.md|CONTRIBUTING\\\\.md\")",
        "hooks": [
          {
            "type": "command",
            "command": "node -e \"const fs=require('fs');let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const p=i.tool_input?.file_path||'';if(/\\\\.(md|txt)$/.test(p)&&!/(README|CLAUDE|AGENTS|CONTRIBUTING)\\\\.md$/.test(p)){console.error('[Hook] BLOCKED: Unnecessary documentation file creation');console.error('[Hook] File: '+p);console.error('[Hook] Use README.md for documentation instead');process.exit(1)}console.log(d)})\""
          }
        ]
      }
    ]
  }
}
```

---

## Skills (스킬)

스킬은 `~/.claude/skills/` 또는 `.claude/skills/`에 폴더로 추가합니다.

### 9. continuous-learning-v2 (자동 학습)

**용도:** 세션에서 패턴을 학습하여 Instinct로 저장, 시간이 지나면 스킬/에이전트로 진화.

**추천 대상:**
- Claude가 내 작업 스타일을 학습하길 원하는 분
- 반복되는 패턴을 자동화하고 싶은 분

**복잡도:** 높음 (여러 파일, 디렉토리 구조 필요)

**핵심 구성:**
```
~/.claude/
├── skills/continuous-learning-v2/
│   ├── SKILL.md
│   ├── config.json
│   ├── hooks/observe.sh
│   └── agents/start-observer.sh
└── homunculus/
    ├── observations.jsonl    # 관찰 데이터
    ├── instincts/personal/   # 학습된 패턴
    └── evolved/              # 진화된 스킬/에이전트
```

**전체 설치:**
```bash
# 저장소 클론
git clone https://github.com/affaan-m/everything-claude-code /tmp/ecc

# continuous-learning-v2 복사
cp -r /tmp/ecc/skills/continuous-learning-v2 ~/.claude/skills/

# 디렉토리 구조 생성
mkdir -p ~/.claude/homunculus/{instincts/{personal,inherited},evolved/{agents,skills,commands}}
touch ~/.claude/homunculus/observations.jsonl

# 관련 명령어 복사
cp /tmp/ecc/commands/instinct-*.md ~/.claude/commands/
cp /tmp/ecc/commands/evolve.md ~/.claude/commands/
cp /tmp/ecc/commands/learn.md ~/.claude/commands/
```

**관련 명령어:**
| 명령어 | 설명 |
|--------|------|
| `/instinct-status` | 학습된 Instinct 확인 |
| `/instinct-export` | Instinct 내보내기 |
| `/instinct-import` | Instinct 가져오기 |
| `/evolve` | Instinct를 스킬로 진화 |

---

## Commands (명령어)

명령어는 `.claude/commands/`에 `.md` 파일로 추가합니다.

### /tdd - TDD 워크플로우

```bash
curl -o .claude/commands/tdd.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/commands/tdd.md
```

### /plan - 기능 계획

```bash
curl -o .claude/commands/plan.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/commands/plan.md
```

### /code-review - 코드 리뷰

```bash
curl -o .claude/commands/code-review.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/commands/code-review.md
```

### /verify - 검증 루프

```bash
curl -o .claude/commands/verify.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/commands/verify.md
```

### /refactor-clean - 리팩토링

```bash
curl -o .claude/commands/refactor-clean.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/commands/refactor-clean.md
```

### /skill-create - 스킬 자동 생성

Git 히스토리에서 패턴을 분석하여 SKILL.md 자동 생성.

```bash
curl -o .claude/commands/skill-create.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/commands/skill-create.md
```

---

## 조합 추천

### 미니멀 세트 (필수만)

```bash
# 에이전트
curl -o ~/.claude/agents/code-reviewer.md \
  https://raw.githubusercontent.com/affaan-m/everything-claude-code/main/agents/code-reviewer.md

# 훅 (settings.json에 추가)
# - console.log 경고
# - Prettier 자동 실행
```

### 품질 중심 세트

```bash
# 에이전트
curl -o ~/.claude/agents/tdd-guide.md [URL]
curl -o ~/.claude/agents/code-reviewer.md [URL]
curl -o ~/.claude/agents/security-reviewer.md [URL]

# 명령어
curl -o .claude/commands/tdd.md [URL]
curl -o .claude/commands/code-review.md [URL]
curl -o .claude/commands/verify.md [URL]

# 훅
# - Prettier
# - TypeScript Check
# - console.log 경고
```

### 풀 세트 (전체)

```bash
/plugin marketplace add affaan-m/everything-claude-code
```

---

## 주의사항

1. **컨텍스트 창 관리**
   - 모든 에이전트/스킬을 한번에 활성화하지 마세요
   - 필요한 것만 선택적으로 사용

2. **훅 충돌**
   - 같은 이벤트에 여러 훅이 있으면 순서대로 실행
   - 하나가 실패하면 다음 훅 실행 안됨

3. **경로 주의**
   - 글로벌: `~/.claude/` (모든 프로젝트)
   - 프로젝트: `.claude/` (해당 프로젝트만)

---

**문서 작성일:** 2026-01-28
