# Vercel Agent Skills

> React/Next.js 개발을 위한 45개 이상의 최적화 규칙

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) |
| **제작자** | Vercel |
| **라이선스** | MIT |
| **분류** | Skill |
| **설치 수** | 50.3K+ (skills.sh 기준 1위) |

---

## 개요

Vercel 엔지니어링 팀이 제작한 React/Next.js 최적화 가이드라인. 워터폴 제거, 번들 사이즈 최적화, 서버 사이드 성능, 리렌더 최적화 등 45개 이상의 규칙을 포함.

---

## 주요 기능

### 1. Async 패턴

| 규칙 | 설명 |
|------|------|
| `async-parallel` | 병렬 데이터 페칭 |
| `async-suspense-boundaries` | Suspense 경계 설정 |
| `async-defer-await` | defer/await 패턴 |
| `async-api-routes` | API 라우트 최적화 |

### 2. 번들 최적화

| 규칙 | 설명 |
|------|------|
| `bundle-dynamic-imports` | 동적 임포트 |
| `bundle-barrel-imports` | 배럴 임포트 최적화 |
| `bundle-conditional` | 조건부 로딩 |
| `bundle-defer-third-party` | 서드파티 지연 로딩 |
| `bundle-preload` | 프리로드 설정 |

### 3. 렌더링 최적화

| 규칙 | 설명 |
|------|------|
| `rendering-activity` | Activity 컴포넌트 |
| `rendering-conditional-render` | 조건부 렌더링 |
| `rendering-content-visibility` | content-visibility |
| `rendering-hoist-jsx` | JSX 호이스팅 |
| `rendering-hydration-no-flicker` | 하이드레이션 깜빡임 방지 |

### 4. 리렌더 최적화

| 규칙 | 설명 |
|------|------|
| `rerender-memo` | React.memo 사용 |
| `rerender-transitions` | useTransition |
| `rerender-derived-state` | 파생 상태 |
| `rerender-functional-setstate` | 함수형 setState |
| `rerender-lazy-state-init` | 지연 상태 초기화 |

### 5. 서버 최적화

| 규칙 | 설명 |
|------|------|
| `server-cache-react` | React 캐시 |
| `server-cache-lru` | LRU 캐시 |
| `server-parallel-fetching` | 병렬 페칭 |
| `server-serialization` | 직렬화 최적화 |

---

## 설치 방법

### npx 사용

```bash
npx add-skill vercel-labs/agent-skills -a claude-code
```

### skills.sh 사용

```bash
npx skills add vercel-labs/agent-skills
```

---

## 사용 예시

### 스킬 실행

```
/react-best-practices
```

### 특정 규칙 확인

```
bundle-dynamic-imports 규칙 설명해줘
```

### 코드 리뷰

```
이 React 컴포넌트를 Vercel 베스트 프랙티스로 리뷰해줘
```

---

## 규칙 목록 (45개)

### JavaScript 최적화 (12개)
- `js-batch-dom-css`, `js-cache-function-results`, `js-cache-property-access`
- `js-cache-storage`, `js-combine-iterations`, `js-early-exit`
- `js-hoist-regexp`, `js-index-maps`, `js-length-check-first`
- `js-min-max-loop`, `js-set-map-lookups`, `js-tosorted-immutable`

### Async 패턴 (6개)
- `async-api-routes`, `async-defer-await`, `async-dependencies`
- `async-parallel`, `async-suspense-boundaries`

### 번들 (5개)
- `bundle-barrel-imports`, `bundle-conditional`, `bundle-defer-third-party`
- `bundle-dynamic-imports`, `bundle-preload`

### 클라이언트 (2개)
- `client-event-listeners`, `client-swr-dedup`

### 렌더링 (7개)
- `rendering-activity`, `rendering-animate-svg-wrapper`, `rendering-conditional-render`
- `rendering-content-visibility`, `rendering-hoist-jsx`, `rendering-hydration-no-flicker`
- `rendering-svg-precision`

### 리렌더 (7개)
- `rerender-defer-reads`, `rerender-dependencies`, `rerender-derived-state`
- `rerender-functional-setstate`, `rerender-lazy-state-init`, `rerender-memo`
- `rerender-transitions`

### 서버 (5개)
- `server-after-nonblocking`, `server-cache-lru`, `server-cache-react`
- `server-parallel-fetching`, `server-serialization`

### 고급 (2개)
- `advanced-event-handler-refs`, `advanced-use-latest`

---

## 장단점

### 장점
- Vercel 공식 가이드라인 (검증된 패턴)
- 45개 규칙으로 포괄적 커버
- 각 규칙에 상세 설명과 예시 포함
- skills.sh 설치 수 1위 (50.3K+)

### 단점/주의사항
- Next.js/React 전용 (다른 프레임워크 불가)
- 모든 규칙이 모든 상황에 적용되지는 않음

---

## 관련 리소스

- [skills.sh](https://skills.sh/) - 스킬 디렉토리
- [Next.js 공식 문서](https://nextjs.org/docs)
- [React 공식 문서](https://react.dev/)

---

**문서 작성일:** 2026-01-28
