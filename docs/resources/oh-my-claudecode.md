# oh-my-claudecode

> 32개 에이전트, 40+ 스킬을 포함한 멀티 에이전트 오케스트레이션 시스템

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/Yeachan-Heo/oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) |
| **제작자** | [@Yeachan-Heo](https://github.com/Yeachan-Heo) |
| **라이선스** | MIT |
| **분류** | Plugin (에이전트 + 스킬 패키지) |

---

## 개요

oh-my-zsh에서 영감을 받은 Claude Code 확장 시스템. 32개의 특화된 에이전트와 40개 이상의 스킬을 제공하며, 복잡한 작업을 위한 멀티 에이전트 오케스트레이션을 지원.

---

## 주요 기능

### 1. 특화된 에이전트 (32개)

| 에이전트 | 용도 |
|---------|------|
| `orchestrator` | 지능형 태스크 위임 |
| `oracle` | 깊은 추론 기술 자문 |
| `librarian` | 외부 문서 및 라이브러리 전문가 |
| `multimodal-looker` | PDF, 이미지, 스크린샷 분석 |
| `frontend-ui-ux-engineer` | 프론트엔드 UI/UX |
| `document-writer` | 기술 문서 작성 |
| `explore` | 코드베이스 탐색 |

### 2. 스킬 (40+)

- 코딩 표준
- TDD 워크플로우
- 보안 리뷰
- 문서화
- 테스트 작성

### 3. Ultrawork 모드

```bash
/ulw  # 또는 /ultrawork
```

최대 강도 작업 모드로 obsessive task completion (Sisyphus Mode) 활성화.

---

## 설치 방법

```bash
/plugin install oh-my-claudecode
```

또는 수동:

```bash
git clone https://github.com/Yeachan-Heo/oh-my-claudecode
cp -r oh-my-claudecode/* ~/.claude/
```

---

## 사용 예시

### 오케스트레이터 사용

```
복잡한 리팩토링 작업을 수행해줘
→ orchestrator가 자동으로 적절한 에이전트에 위임
```

### Oracle로 기술 자문

```
이 아키텍처 결정에 대해 깊이 분석해줘
→ oracle 에이전트가 심층 추론으로 분석
```

### Ultrawork 모드

```
/ulw
대규모 마이그레이션 작업 시작
→ 끝날 때까지 집요하게 작업 수행
```

---

## 장단점

### 장점
- 32개 특화 에이전트로 대부분의 작업 커버
- 멀티 에이전트 오케스트레이션 지원
- Ultrawork 모드로 복잡한 작업 완수
- oh-my-zsh 스타일의 친숙한 구조

### 단점/주의사항
- 많은 에이전트/스킬로 컨텍스트 창 소비 가능
- 필요한 것만 선택적으로 활성화 권장

---

## 관련 리소스

- [oh-my-zsh](https://ohmyz.sh/) - 영감을 준 프로젝트
- [everything-claude-code](./everything-claude-code.md) - 유사한 종합 설정

---

**문서 작성일:** 2026-01-28
