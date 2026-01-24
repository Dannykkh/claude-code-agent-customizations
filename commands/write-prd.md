---
description: PRD (Product Requirements Document) 작성
allowed-tools: Read, Write, Glob, Grep
---

# PRD 작성 가이드

주어진 기능/프로젝트에 대한 PRD를 다음 구조로 작성하세요.

## 출력 구조

```markdown
# [기능명] PRD

## 1. Executive Summary
- 프로젝트 목적 (1-2문단)
- 핵심 가치 제안

## 2. Objectives
- 구체적이고 측정 가능한 목표
- O-001: [목표 설명]
- O-002: [목표 설명]

## 3. User Stories
- As a [역할], I want [기능], so that [가치]
- US-001: As a 관리자, I want 데이터를 업로드, so that 최신 데이터를 사용할 수 있다
- US-002: ...

## 4. Functional Requirements
- FR-001: [기능 설명]
- FR-002: [기능 설명]

## 5. Non-Functional Requirements
### 5.1 성능
- 응답 시간 < 200ms
- 동시 사용자 1000명 지원

### 5.2 보안
- API Key 인증
- Rate Limiting

### 5.3 확장성
- 수평 확장 가능한 아키텍처

## 6. Success Metrics
- KPI 정의
- 목표 수치

## 7. Out of Scope
- 포함되지 않는 기능 명시

## 8. Dependencies
- 외부 시스템 의존성
- 내부 모듈 의존성

## 9. Timeline (Optional)
- 마일스톤 정의
```

## 출력 위치
`docs/prd/[기능명].md`

## 실행 예시
```
/write-prd 사용자 관리 기능
```
