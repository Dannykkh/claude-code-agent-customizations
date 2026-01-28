# awesome-claude-code

> Claude Code 리소스의 커뮤니티 큐레이션 모음 (22.1K 스타)

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) |
| **라이선스** | MIT |
| **분류** | 큐레이션 리스트 |
| **스타** | 22.1K+ |

---

## 개요

Claude Code를 향상시키기 위한 커뮤니티 큐레이션 자료 모음. Agent Skills, 워크플로우 가이드, 도구, 훅, 슬래시 명령어, CLAUDE.md 파일 등을 카테고리별로 정리합니다.

---

## 카테고리

### 1. Agent Skills

Claude Code가 특정 작업을 수행하도록 하는 모델 제어 구성:

| 스킬 | 설명 |
|------|------|
| **Claude Codex Settings** | 클라우드 플랫폼, MongoDB 등 통합 |
| **Compound Engineering Plugin** | 실수로부터 배우는 에이전트 |
| **Trail of Bits Security Skills** | 코드 감사 및 취약점 탐지 |
| **obra/superpowers** | 20개 이상의 전투 테스트 스킬 |
| **loki-mode** | 37개 AI 에이전트 조율 (스타트업 자동화) |

### 2. Workflows & Knowledge Guides

프로젝트 관리와 개발 프로세스:

| 가이드 | 설명 |
|--------|------|
| **AB Method** | Spec 기반 워크플로우 |
| **Learn Claude Code** | 에이전트 구조 분석 |
| **Project Management Systems** | 여러 프로젝트 관리 |

### 3. Tooling

Claude Code 위에 구축된 애플리케이션:

| 분류 | 도구 |
|------|------|
| **IDE 통합** | VS Code, Neovim, Emacs |
| **사용량 모니터링** | CCUsage, ccflare |
| **오케스트레이터** | 여러 에이전트 관리 |

### 4. Hooks

Claude의 생명주기에서 실행되는 스크립트:

| 훅 | 설명 |
|----|------|
| **Britfix** | 영국 영어 자동 변환 |
| **TDD Guard** | 테스트 주도 개발 원칙 감시 |
| **Auto-formatter** | 코드 자동 포맷팅 |

### 5. Slash-Commands

특정 작업을 위한 커스터마이징된 프롬프트:

| 분류 | 명령어 |
|------|--------|
| **Git/버전 관리** | /commit, /pr, /rebase |
| **코드 분석** | /review, /explain, /refactor |
| **테스트** | /test, /coverage |
| **문서화** | /docs, /changelog |

### 6. CLAUDE.md Files

언어별, 도메인별 프로젝트 컨텍스트 파일:

| 분류 | 예시 |
|------|------|
| **언어별** | Python, TypeScript, Go, Rust |
| **프레임워크별** | React, Django, Spring Boot |
| **도메인별** | 금융, 의료, 게임 |

---

## 주요 프로젝트 하이라이트

### Trail of Bits Security Skills

보안 전문 회사의 코드 감사 스킬:
- 취약점 탐지 자동화
- OWASP Top 10 검증
- 암호화 패턴 검사

### loki-mode

스타트업 자동화 시스템:
- 37개 AI 에이전트
- 코드 생성 → 테스트 → 배포 자동화
- 피드백 루프

### obra/superpowers

20개 이상의 실전 검증 스킬:
- 코드 생성
- 리팩토링
- 문서화
- 테스트 작성

---

## 사용 방법

### 스킬 설치

```bash
# 플러그인 마켓플레이스
/plugin marketplace add <skill-name>

# 직접 복사
cp skills/* ~/.claude/skills/
```

### 훅 적용

```bash
# settings.json에 추가
cp hooks.json ~/.claude/settings.json
```

### CLAUDE.md 사용

```bash
# 프로젝트 루트에 복사
cp CLAUDE.md ./.claude/CLAUDE.md
```

---

## 장단점

### 장점
- 22.1K 스타로 검증된 품질
- 커뮤니티 활발히 기여
- 다양한 카테고리 포괄
- 지속적 업데이트

### 단점/주의사항
- 너무 많은 옵션으로 선택 어려움
- 일부 리소스는 관리 안됨
- 품질이 일관되지 않음

---

## 관련 리소스

- [awesome-claude-skills](./awesome-claude-skills.md) - 스킬 전문 큐레이션
- [awesome-claude-code-subagents](./awesome-claude-code-subagents.md) - 에이전트 컬렉션

---

**문서 작성일:** 2026-01-28
