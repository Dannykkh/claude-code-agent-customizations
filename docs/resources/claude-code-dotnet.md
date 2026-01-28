# claude-code-dotnet

> .NET 개발자를 위한 25개 스킬과 5개 전문 에이전트

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/Aaronontheweb/claude-code-dotnet](https://github.com/Aaronontheweb/claude-code-dotnet) |
| **제작자** | Aaron Stannard (Akka.NET 창시자) |
| **라이선스** | MIT |
| **분류** | Skill + Agent 패키지 |

---

## 개요

프로덕션 시스템에서 검증된 .NET 개발 패턴을 담은 Claude Code 플러그인. C#, ASP.NET Core, Entity Framework, Akka.NET 등 .NET 생태계 전반을 다룹니다.

**핵심 원칙:**
- 불변성 (Immutability)
- 타입 안전성 (Type Safety)
- 성능 인식 (Performance Awareness)
- 테스트 가능성 (Testability)
- "매직 없음" (No AutoMapper 등)

---

## 5개 전문 에이전트

| 에이전트 | 전문 분야 |
|---------|----------|
| **akka-net-specialist** | 액터 시스템, 클러스터링, 메시지 패턴 |
| **dotnet-concurrency-specialist** | 스레딩, 비동기 처리, 데드락 분석 |
| **dotnet-benchmark-designer** | BenchmarkDotNet 설정, 성능 측정 |
| **dotnet-performance-analyst** | 프로파일러 분석, 회귀 감지 |
| **docfx-specialist** | 문서 생성, API 문서화 |

---

## 25개 스킬 카테고리

### Akka.NET (5개)
- 모범 사례
- 테스트 패턴
- 호스팅 패턴
- Aspire 통합
- 관리

### C# 언어 (4개)
- 코딩 표준
- 동시성 패턴
- API 설계
- 타입 설계

### 데이터 접근 (2개)
- Entity Framework Core
- 성능 최적화

### .NET Aspire (2개)
- 통합 테스트
- 서비스 기본값

### ASP.NET Core (1개)
- 이메일 템플릿

### .NET 생태계 (5개)
- 프로젝트 구조
- 패키지 관리
- 직렬화
- 로컬 도구

### Microsoft.Extensions (2개)
- 설정
- 의존성 주입

### 테스트 (4개)
- Testcontainers
- Playwright
- 커버리지
- 스냅샷 테스팅

---

## 설치 방법

```bash
# 플러그인 마켓플레이스에서 설치
/plugin marketplace add Aaronontheweb/dotnet-skills
/plugin install dotnet-skills

# 업데이트
/plugin marketplace update
```

---

## 사용 예시

### WPF 앱 개발
```
WPF MVVM 패턴으로 사용자 관리 화면 만들어줘
→ dotnet-skills가 불변성과 타입 안전성 원칙 적용
```

### Akka.NET 클러스터링
```
Akka.NET으로 분산 액터 시스템 설계해줘
→ akka-net-specialist 에이전트 활성화
```

### 성능 벤치마크
```
이 코드의 성능을 BenchmarkDotNet으로 측정해줘
→ dotnet-benchmark-designer 에이전트 활성화
```

---

## 장단점

### 장점
- Akka.NET 창시자가 직접 제작
- 프로덕션 검증된 패턴
- 5개 전문 에이전트로 깊은 지원
- .NET 최신 기능 반영

### 단점/주의사항
- .NET 전용 (다른 언어 불가)
- Akka.NET 스킬은 해당 프레임워크 사용자만 해당

---

## 관련 리소스

- [Akka.NET](https://getakka.net/) - 액터 프레임워크
- [.NET Aspire](https://learn.microsoft.com/aspire) - 클라우드 네이티브 스택
- [BenchmarkDotNet](https://benchmarkdotnet.org/) - 성능 측정

---

**문서 작성일:** 2026-01-28
