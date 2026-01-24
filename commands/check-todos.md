---
description: 프로젝트 TODO 항목 검토 및 우선순위 분류
allowed-tools: Grep, Read, Glob
---

# TODO 검토 가이드

프로젝트 내 모든 TODO, FIXME, XXX, HACK 주석을 검색하고 우선순위별로 분류합니다.

## 검색 대상 파일
- `**/*.py` - Python 파일
- `**/*.ts` - TypeScript 파일
- `**/*.tsx` - React 컴포넌트
- `**/*.js` - JavaScript 파일
- `**/*.md` - 마크다운 문서

## 검색 패턴
```
TODO|FIXME|XXX|HACK|BUG|OPTIMIZE|REVIEW
```

## 우선순위 분류 기준

### P0 (Critical) - 즉시 처리
- 보안 취약점 관련
- 데이터 손실 가능성
- 서비스 중단 위험
- `FIXME`, `BUG` 태그

### P1 (High) - 이번 스프린트
- 핵심 기능 미완성
- 성능 이슈
- 사용자 경험 저하
- `XXX`, `HACK` 태그 (임시 코드)

### P2 (Medium) - 다음 스프린트
- 코드 품질 개선
- 리팩토링 필요
- 테스트 추가 필요
- `TODO` 태그 (기능 구현)

### P3 (Low) - 백로그
- 문서화 개선
- 코드 스타일 정리
- 최적화 (선택적)
- `OPTIMIZE`, `REVIEW` 태그

## 출력 형식

```markdown
# TODO 검토 보고서

생성일: YYYY-MM-DD

## 요약
| 우선순위 | 개수 | 예상 작업량 |
|----------|------|-------------|
| P0 (Critical) | 2 | 4h |
| P1 (High) | 5 | 8h |
| P2 (Medium) | 10 | 16h |
| P3 (Low) | 8 | 8h |

---

## P0 (Critical) - 즉시 처리

### 1. [파일경로:라인번호]
```
// FIXME: SQL Injection 취약점
```
- **설명**: 사용자 입력이 직접 쿼리에 삽입됨
- **예상 작업량**: 2h
- **담당자 제안**: Backend 팀

---

## P1 (High) - 이번 스프린트
...
```

## 실행 예시
```
/check-todos
/check-todos backend
/check-todos frontend
```
