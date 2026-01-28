# skills.sh

> Vercel이 만든 25,000+ 스킬 디렉토리 및 설치 도구

## 기본 정보

| 항목 | 내용 |
|------|------|
| **웹사이트** | [skills.sh](https://skills.sh/) |
| **제작자** | Vercel |
| **분류** | 스킬 디렉토리 / CLI 도구 |
| **스킬 수** | 25,000+ |

---

## 개요

skills.sh는 Claude Code 스킬을 검색하고 설치할 수 있는 중앙 디렉토리. `npx skills add` 명령어로 GitHub 저장소에서 스킬을 자동 설치.

---

## 주요 기능

### 1. 스킬 검색

웹사이트에서 카테고리별, 인기순으로 스킬 검색 가능.

### 2. 원클릭 설치

```bash
npx skills add <owner/repo>
```

### 3. 인기 스킬 순위

설치 수 기준 인기 스킬 랭킹 제공.

---

## 설치 방법

별도 설치 불필요. npx로 바로 사용.

```bash
npx skills add <owner/repo>
```

---

## 사용 예시

### 스킬 설치

```bash
# Vercel React 베스트 프랙티스
npx skills add vercel-labs/agent-skills

# 웹 디자인 가이드라인
npx skills add anthonycorletti/web-design-guidelines

# TypeScript 마스터
npx skills add SpillwaveSolutions/mastering-typescript-skill
```

### 특정 브랜치에서 설치

```bash
npx skills add owner/repo --branch feature-branch
```

---

## 인기 스킬 TOP 10

| 순위 | 스킬 | 설치 수 | 설명 |
|------|------|---------|------|
| 1 | vercel-react-best-practices | 50.3K | React 개발 가이드 |
| 2 | web-design-guidelines | 38.2K | 웹 디자인 원칙 |
| 3 | remotion-best-practices | 34.4K | Remotion 비디오 프레임워크 |
| 4 | frontend-design | 15.3K | 프론트엔드 아키텍처 |
| 5 | supabase-postgres-best-practices | 4.4K | 데이터베이스 패턴 |
| 6 | mastering-typescript-skill | 3.8K | TypeScript 엔터프라이즈 |
| 7 | claude-code-dotnet | 2.1K | C#/.NET 개발 |
| 8 | pg-aiguide | 1.5K | PostgreSQL 가이드 |
| 9 | golang-best-practices | 1.2K | Go 언어 패턴 |
| 10 | python-backend-guide | 0.9K | Python 백엔드 |

---

## 카테고리별 스킬

### Frontend
- vercel-react-best-practices
- frontend-design
- remotion-best-practices
- web-design-guidelines

### Backend
- mastering-typescript-skill
- python-backend-guide
- golang-best-practices

### Database
- supabase-postgres-best-practices
- pg-aiguide

### DevOps
- docker-best-practices
- kubernetes-guide

### AI/ML
- langchain-guide
- llm-integration

---

## 장단점

### 장점
- 25,000+ 스킬로 대부분의 기술 스택 커버
- npx로 간편 설치
- 인기순 정렬로 검증된 스킬 찾기 쉬움
- Vercel 공식 운영

### 단점/주의사항
- 스킬 품질이 일관되지 않음 (커뮤니티 기여)
- 중복 스킬 존재
- 일부 스킬은 오래되어 관리 안됨

---

## 관련 리소스

- [Claude Code 공식 문서](https://docs.anthropic.com/claude-code)
- [awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills) - 큐레이션된 스킬 목록

---

**문서 작성일:** 2026-01-28
