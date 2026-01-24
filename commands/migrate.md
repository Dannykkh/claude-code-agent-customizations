# Migrate: $ARGUMENTS

레거시 코드를 신규 아키텍처로 마이그레이션합니다.

## 대상
`$ARGUMENTS` (예: controller, service, entity, page)

## 마이그레이션 유형

### 1. Controller 마이그레이션
```
/migrate controller ItemController
```

**수행 작업:**
1. 전략 문서 확인
2. `@explore-agent`로 기존 컨트롤러 분석
3. Request/Response DTO 생성
4. REST Controller 구현
5. 테스트 코드 작성
6. `@qa-agent`로 검증

### 2. Service 마이그레이션
```
/migrate service ItemService
```

**수행 작업:**
1. 기존 서비스 분석
2. 신규 서비스 인터페이스 설계
3. 구현 클래스 작성
4. 단위 테스트 작성

### 3. Entity 마이그레이션
```
/migrate entity Item
```

**수행 작업:**
1. 기존 Entity/VO 분석
2. JPA Entity 생성
3. Repository 생성
4. 테스트 작성

### 4. Page 마이그레이션 (Template → React)
```
/migrate page item/list
```

**수행 작업:**
1. `@explore-agent`로 템플릿 분석
2. TypeScript 타입 정의
3. API 클라이언트 생성
4. React Query 훅 생성
5. React 컴포넌트 구현
6. `@qa-agent`로 검증

## 마이그레이션 워크플로우

```
┌────────────────────────────────────────────────┐
│ STEP 0: 전략 문서 확인                          │
├────────────────────────────────────────────────┤
│ STEP 1: 기존 코드 분석                          │
│ → @explore-agent 호출                          │
├────────────────────────────────────────────────┤
│ STEP 2: 신규 코드 구현                          │
│ → @migration-helper 참고                       │
├────────────────────────────────────────────────┤
│ STEP 3: 테스트 작성                            │
│ → 단위 테스트 + 통합 테스트                     │
├────────────────────────────────────────────────┤
│ STEP 4: QA 검증                               │
│ → @qa-agent 호출                              │
├────────────────────────────────────────────────┤
│ STEP 5: 완료 보고                              │
│ → @feature-tracker 업데이트                    │
└────────────────────────────────────────────────┘
```

## 마이그레이션 체크리스트

### 백엔드
- [ ] DTO 생성 (Request, Response)
- [ ] Controller 구현
- [ ] Service 구현 (기존 로직 재사용)
- [ ] Repository 구현 (필요시)
- [ ] 테스트 작성
- [ ] i18n 메시지 추가

### 프론트엔드
- [ ] TypeScript 타입 정의
- [ ] API 클라이언트 구현
- [ ] React Query 훅 구현
- [ ] 컴포넌트 구현
- [ ] 페이지 구현
- [ ] i18n 키 추가

## 출력

마이그레이션 완료 후:
1. 생성/수정된 파일 목록
2. 변환 전후 비교 테이블
3. QA 결과 요약
4. 다음 단계 안내
