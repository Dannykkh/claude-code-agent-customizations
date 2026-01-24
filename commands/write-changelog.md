---
description: Git 커밋 기반 Changelog 자동 생성
allowed-tools: Bash, Write, Read
argument-hint: [version]
---

# Changelog 생성 가이드

Git 커밋 히스토리를 분석하여 CHANGELOG.md를 자동 업데이트합니다.

## 커밋 분석 명령

```bash
git log --oneline --since="2 weeks ago"
```

## 커밋 메시지 분류 규칙

### Conventional Commits 패턴
- `feat:` → Added
- `fix:` → Fixed
- `docs:` → Documentation
- `style:` → Changed (스타일)
- `refactor:` → Changed (리팩토링)
- `perf:` → Performance
- `test:` → Tests
- `chore:` → Chores
- `security:` → Security

## 출력 구조

```markdown
# Changelog

All notable changes to this project will be documented in this file.

## [버전] - YYYY-MM-DD

### Added
- 새로운 기능 설명 (#PR번호)
- 사용자 프로필 이미지 업로드 기능 추가

### Changed
- 변경된 기능 설명
- 검색 API 응답 구조 개선

### Fixed
- 버그 수정 설명
- 페이지네이션 중복 결과 제거

### Deprecated
- 더 이상 사용되지 않는 기능

### Removed
- 제거된 기능

### Security
- 보안 패치 설명
- API 인증 로직 강화

---

## [이전 버전] - YYYY-MM-DD
...
```

## 출력 위치
`CHANGELOG.md` (프로젝트 루트)

## 실행 예시
```
/write-changelog 1.0.0
/write-changelog 1.1.0
```

## 주의사항
- 기존 CHANGELOG.md가 있으면 맨 위에 새 버전을 추가
- 버전 번호는 Semantic Versioning (SemVer) 사용
- 각 항목에 관련 PR/이슈 번호 포함 권장
