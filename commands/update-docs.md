# Update Docs

문서를 업데이트합니다.

## 사용법
```
/update-docs                    # 전체 문서 상태 확인 및 업데이트
/update-docs Item               # Item 모듈 문서 업데이트
/update-docs api                # API 문서만 업데이트
/update-docs progress           # 진행 상황 문서 업데이트
```

## 업데이트 대상 문서

### 1. 기능별 문서
```
docs/{기능명}/
├── PRD.md              # 요구사항 문서
├── API.md              # API 명세
└── IMPLEMENTATION.md   # 구현 추적
```

### 2. 전체 프로젝트 문서
```
./
├── FEATURE_TRACKER.md  # 기능 진행 현황
├── CHANGELOG.md        # 변경 이력
└── README.md           # 프로젝트 개요
```

## 업데이트 프로세스

### 1단계: 변경사항 수집

```bash
# 최근 변경된 파일
git diff --name-only HEAD~5

# 커밋 히스토리
git log --oneline -10
```

### 2단계: 문서 상태 확인

```bash
# PRD 파일 목록
find . -name "PRD.md"

# IMPLEMENTATION 파일 목록
find . -name "IMPLEMENTATION.md"

# API 문서 목록
find . -name "API.md"
```

### 3단계: 업데이트 실행

#### PRD.md 업데이트
- 요구사항 변경 반영
- 상태 업데이트 (Draft → Approved)

#### API.md 업데이트
- 새 엔드포인트 추가
- 요청/응답 형식 수정
- 에러 코드 추가

#### IMPLEMENTATION.md 업데이트
- 체크리스트 진행 상황
- 완료 일시 기록
- 이슈 및 해결 내용

#### FEATURE_TRACKER.md 업데이트
- 기능별 상태 변경
- 진행률 계산
- 우선순위 조정

## 자동 감지 항목

### 코드 → 문서 동기화

```
새 Controller 생성됨
→ API.md에 엔드포인트 추가 필요

테스트 통과
→ IMPLEMENTATION.md 체크리스트 업데이트

QA 통과
→ 상태를 "QA 완료"로 변경
```

### 불일치 감지

```markdown
⚠️ 문서 불일치 감지:

1. ItemController에 새 엔드포인트 추가됨
   - POST /api/v1/items/bulk
   - API.md에 문서화 필요

2. IMPLEMENTATION.md 체크리스트 미갱신
   - 백엔드 QA 통과했으나 미체크
```

## 출력 형식

```markdown
# 📄 문서 업데이트 결과

## 업데이트 요약
- **대상**: $ARGUMENTS
- **업데이트 파일**: N개
- **신규 생성**: N개

## 변경 내용

### docs/item/API.md
```diff
+ ### POST /api/v1/items/bulk
+ 아이템 일괄 등록
```

### docs/item/IMPLEMENTATION.md
- [x] 백엔드 QA 통과 ← 체크됨
- 완료일: 2024-01-15

### FEATURE_TRACKER.md
- 아이템 일괄 등록: ⬜ → 🔄 (진행 중)
- 전체 진행률: 40% → 42%

## 감지된 이슈
1. ⚠️ Order API.md 미생성 - 생성 필요
2. ⚠️ Cart PRD.md 오래됨 - 검토 필요

## 다음 단계
1. 생성된 문서 검토
2. 누락된 문서 작성
3. @docs-agent로 상세 문서 갱신
```

## 자동 호출

`/update-docs` 실행 시:
1. `@docs-agent` 서브에이전트 활용
2. `@feature-tracker` 진행률 갱신
3. CHANGELOG.md 자동 업데이트
