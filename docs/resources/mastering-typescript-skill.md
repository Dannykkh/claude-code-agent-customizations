# mastering-typescript-skill

> 엔터프라이즈급 TypeScript 개발을 위한 종합 가이드

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/SpillwaveSolutions/mastering-typescript-skill](https://github.com/SpillwaveSolutions/mastering-typescript-skill) |
| **제작자** | SpillwaveSolutions |
| **라이선스** | MIT |
| **분류** | Skill |
| **설치 수** | 3.8K+ (skills.sh 기준) |

---

## 개요

Claude Code를 위한 엔터프라이즈급 TypeScript 개발 가이드. 타입 시스템 심화, 제네릭 패턴, 프레임워크 통합(React, NestJS)을 다룹니다.

**지원 기술 스택 (2025년 12월 기준):**
- TypeScript 5.9+
- Node.js 22 LTS
- Vite 7
- pnpm 9
- NestJS 11
- React 19
- ESLint 9

---

## 주요 기능

### 1. 타입 시스템 심화

```typescript
// Union & Intersection Types
type Result<T> = Success<T> | Failure;

// Discriminated Unions
type Action =
  | { type: 'INCREMENT'; payload: number }
  | { type: 'RESET' };
```

### 2. 제네릭 패턴

```typescript
// 함수 제네릭
function identity<T>(value: T): T {
  return value;
}

// 인터페이스 제네릭
interface Repository<T> {
  find(id: string): Promise<T>;
  save(entity: T): Promise<void>;
}

// 클래스 제네릭
class Cache<T> {
  private items = new Map<string, T>();
}
```

### 3. 엔터프라이즈 패턴

```typescript
// Result/Either 타입
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };

// Zod 검증
const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
});

// 브랜디드 타입
type UserId = string & { __brand: 'UserId' };
```

### 4. 프레임워크 통합

**React 19:**
- 서버 컴포넌트
- use() 훅
- 상태 관리

**NestJS 11:**
- 의존성 주입
- 모듈 시스템
- 데코레이터 패턴

---

## 스킬 구조

```
references/
├── type-system.md          # 타입 시스템 가이드
├── generics.md             # 제네릭 패턴
├── enterprise-patterns.md  # 엔터프라이즈 패턴
├── react-integration.md    # React 통합
└── nestjs-integration.md   # NestJS 통합

assets/                     # 템플릿 및 설정 파일
scripts/                    # 유틸리티 스크립트
```

---

## 설치 방법

### npx 사용

```bash
npx add-skill SpillwaveSolutions/mastering-typescript-skill -a claude-code
```

### skilz 사용

```bash
pip install skilz
skilz install -g https://github.com/SpillwaveSolutions/mastering-typescript-skill
```

---

## 사용 예시

### 타입 안전한 API 클라이언트

```
타입 안전한 REST API 클라이언트를 만들어줘
→ 제네릭과 브랜디드 타입 패턴 적용
```

### NestJS 모듈 설계

```
NestJS로 인증 모듈 설계해줘
→ NestJS 11 베스트 프랙티스 적용
```

### Zod 스키마 검증

```
회원가입 폼 검증 로직을 Zod로 만들어줘
→ Result 타입과 Zod 패턴 적용
```

---

## 장단점

### 장점
- 최신 TypeScript 5.9+ 지원
- NestJS, React 최신 버전 통합
- 엔터프라이즈 패턴 포함 (Result, Branded Types)
- 실용적인 코드 예시 다수

### 단점/주의사항
- TypeScript 전용
- skilz 또는 npx 설치 필요
- 초급자에게는 다소 고급 내용

---

## 관련 리소스

- [TypeScript 공식 문서](https://www.typescriptlang.org/docs/)
- [NestJS 공식 문서](https://docs.nestjs.com/)
- [Zod](https://zod.dev/) - TypeScript 스키마 검증

---

**문서 작성일:** 2026-01-28
