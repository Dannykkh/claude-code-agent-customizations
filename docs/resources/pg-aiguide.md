# pg-aiguide

> AI 코딩 도구가 더 나은 PostgreSQL 코드를 작성하도록 돕는 MCP 서버

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/timescale/pg-aiguide](https://github.com/timescale/pg-aiguide) |
| **제작자** | Timescale |
| **라이선스** | Apache 2.0 |
| **분류** | MCP 서버 + Claude 플러그인 |
| **MCP URL** | `https://mcp.tigerdata.com/docs` |

---

## 개요

Timescale이 개발한 PostgreSQL 전문 MCP 서버. PostgreSQL 공식 매뉴얼을 의미론적으로 검색하고, 큐레이션된 베스트 프랙티스를 제공합니다.

**효과 (테스트 결과):**
- 제약조건 **4배** 증가
- 인덱스 **55%** 증가
- PostgreSQL 17 권장 패턴 자동 적용
- `GENERATED ALWAYS AS IDENTITY` 등 현대 기능 활용

---

## 주요 기능

### 1. 의미론적 검색

**PostgreSQL 매뉴얼 검색:**
- 공식 PostgreSQL 매뉴얼 전체
- 버전 인식 방식 (PostgreSQL 12~17)
- 의미론적 검색으로 관련 문서 찾기

**생태계 문서 검색:**
- TimescaleDB 문서
- pgvector, PostGIS (준비 중)

### 2. AI 최적화 스킬

큐레이션된 PostgreSQL 베스트 프랙티스:

| 분야 | 내용 |
|------|------|
| **스키마 설계** | 정규화, 관계 설계, 파티셔닝 |
| **인덱싱 전략** | B-tree, GIN, GiST, 부분 인덱스 |
| **데이터 타입** | 적절한 타입 선택, JSONB vs JSON |
| **제약 조건** | FK, CHECK, UNIQUE, NOT NULL |
| **명명 규칙** | 테이블, 컬럼, 인덱스 네이밍 |
| **성능 튜닝** | 쿼리 최적화, EXPLAIN 분석 |
| **현대 기능** | GENERATED ALWAYS, CTE, 윈도우 함수 |

### 3. 확장 생태계

| 확장 | 상태 |
|------|------|
| TimescaleDB | 지원 |
| pgvector | 준비 중 |
| PostGIS | 준비 중 |

---

## 설치 방법

### Claude Code

```bash
claude plugin install pg-aiguide
```

### MCP 서버 직접 설정

```json
{
  "mcpServers": {
    "pg-aiguide": {
      "type": "http",
      "url": "https://mcp.tigerdata.com/docs"
    }
  }
}
```

### 지원 도구

- Claude Code
- Cursor
- VS Code
- Windsurf

---

## 사용 예시

### 스키마 설계

```
사용자와 주문 테이블을 PostgreSQL로 설계해줘
→ pg-aiguide가 제약조건, 인덱스, 현대 기능 자동 적용
```

### 쿼리 최적화

```
이 쿼리가 느린데 최적화해줘
→ PostgreSQL 매뉴얼에서 관련 최적화 기법 검색
```

### 인덱스 설계

```
검색 성능을 위한 인덱스 전략 추천해줘
→ B-tree, GIN, 부분 인덱스 등 상황별 추천
```

### TimescaleDB 시계열

```
TimescaleDB로 센서 데이터 저장 구조 설계해줘
→ TimescaleDB 문서에서 hypertable 패턴 적용
```

---

## pg-aiguide 적용 전후 비교

### 적용 전

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255),
  created_at TIMESTAMP
);
```

### 적용 후

```sql
CREATE TABLE users (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT users_email_check CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_created_at ON users (created_at DESC);
```

---

## 장단점

### 장점
- PostgreSQL 공식 매뉴얼 의미론적 검색
- 버전별 문서 지원 (12~17)
- 제약조건/인덱스 자동 권장
- Timescale 공식 지원
- 무료 사용

### 단점/주의사항
- PostgreSQL 전용 (MySQL, SQLite 등 불가)
- pgvector, PostGIS는 아직 준비 중
- 네트워크 연결 필요

---

## 관련 리소스

- [PostgreSQL 공식 문서](https://www.postgresql.org/docs/)
- [TimescaleDB](https://www.timescale.com/)
- [Timescale MCP](https://mcp.tigerdata.com/)

---

**문서 작성일:** 2026-01-28
