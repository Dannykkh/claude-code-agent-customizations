# Toss Payments MCP

> PG 업계 최초 MCP 서버, 10분 만에 결제 연동

## 기본 정보

| 항목 | 내용 |
|------|------|
| **공식 글** | [toss.tech/article/tosspayments-mcp](https://toss.tech/article/tosspayments-mcp) |
| **NPM** | [@tosspayments/integration-guide-mcp](https://www.npmjs.com/package/@tosspayments/integration-guide-mcp) |
| **제작자** | 토스페이먼츠 |
| **분류** | MCP 서버 |

---

## 개요

토스페이먼츠가 제공하는 Claude Code MCP 서버. PG 업계 최초로, 결제 연동 가이드, API 문서, 샘플 코드를 Claude에게 직접 제공하여 10분 만에 결제 연동 가능.

---

## 주요 기능

### 1. 결제 연동 가이드

- 토스페이먼츠 결제 위젯 연동
- 일반 결제 / 정기 결제 / 에스크로
- 브랜드페이 연동

### 2. API 레퍼런스

- 결제 승인/취소/조회 API
- 정산 API
- 본인인증 API

### 3. 샘플 코드

- React, Next.js, Vue 샘플
- Node.js, Java, Python 백엔드 샘플

### 4. 에러 핸들링

- 결제 실패 사유 및 해결 방법
- 테스트/라이브 환경 전환 가이드

---

## 설치 방법

```bash
claude mcp add tosspayments -- npx -y @tosspayments/integration-guide-mcp@latest
```

---

## 사용 예시

### 결제 위젯 연동

```
React에서 토스페이먼츠 결제 위젯 연동해줘
→ MCP가 최신 가이드와 샘플 코드 제공
```

### API 호출

```
결제 취소 API 호출 방법 알려줘
→ API 명세, 요청/응답 예시, 에러 처리 포함
```

### 에러 해결

```
INVALID_CARD_COMPANY 에러가 발생했어
→ 에러 원인과 해결 방법 제공
```

---

## 지원 기능 목록

| 기능 | 설명 |
|------|------|
| 일반 결제 | 카드, 계좌이체, 가상계좌, 휴대폰 |
| 정기 결제 | 빌링키 발급 및 결제 |
| 에스크로 | 안전거래 |
| 브랜드페이 | 토스페이, 삼성페이, 네이버페이 등 |
| 본인인증 | 휴대폰 인증 |
| 정산 | 정산 내역 조회 |

---

## 장단점

### 장점
- PG 업계 최초 MCP (선구자)
- 10분 만에 결제 연동 가능
- 최신 문서 자동 동기화
- 토스페이먼츠 공식 지원

### 단점/주의사항
- 토스페이먼츠 전용 (타 PG 불가)
- 실제 결제 테스트는 테스트 API 키 필요
- 한국어 문서 기반

---

## 관련 리소스

- [토스페이먼츠 개발자센터](https://developers.tosspayments.com/)
- [토스페이먼츠 GitHub](https://github.com/tosspayments)
- [MCP 발표 블로그](https://toss.tech/article/tosspayments-mcp)

---

**문서 작성일:** 2026-01-28
