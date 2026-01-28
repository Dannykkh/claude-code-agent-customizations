# Office-PowerPoint-MCP-Server

> PowerPoint 자동화를 위한 32개 도구와 25개 템플릿 제공

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/GongRzhe/Office-PowerPoint-MCP-Server](https://github.com/GongRzhe/Office-PowerPoint-MCP-Server) |
| **제작자** | GongRzhe |
| **라이선스** | MIT |
| **분류** | MCP 서버 |
| **스타** | 1.5K+ |
| **API 키** | 불필요 (로컬 실행) |

---

## 개요

PowerPoint 조작을 위한 종합 MCP 서버. 프레젠테이션 생성부터 고급 디자인까지 32개의 도구를 11개의 모듈로 제공합니다.

**핵심 기능:**
- Open XML(.pptx) 완전 호환
- 템플릿 기반 테마/레이아웃 자동 보존
- 다중 프레젠테이션 동시 관리
- 25개 이상의 전문가용 슬라이드 템플릿

---

## 32개 도구 (11개 모듈)

### 프레젠테이션 관리 (7개)

| 도구 | 기능 |
|------|------|
| `create_presentation` | 새 프레젠테이션 생성 |
| `open_presentation` | 기존 파일 열기 |
| `save_presentation` | 파일 저장 |
| `get_presentation_info` | 메타데이터 조회 |
| `set_presentation_metadata` | 제목, 저자 등 설정 |
| `get_slide_count` | 슬라이드 수 확인 |
| `close_presentation` | 파일 닫기 |

### 콘텐츠 관리 (8개)

| 도구 | 기능 |
|------|------|
| `add_slide` | 슬라이드 추가 |
| `delete_slide` | 슬라이드 삭제 |
| `duplicate_slide` | 슬라이드 복제 |
| `add_text_box` | 텍스트 박스 추가 |
| `add_image` | 이미지 추가 |
| `extract_text` | 텍스트 추출 |
| `get_slide_content` | 슬라이드 내용 조회 |
| `manage_text` | 텍스트 추가/포맷팅 |

### 템플릿 작업 (7개)

| 도구 | 기능 |
|------|------|
| `apply_template` | 템플릿 적용 |
| `get_available_layouts` | 사용 가능 레이아웃 |
| `create_from_template` | 템플릿으로 생성 |
| `auto_generate_presentation` | 자동 생성 |
| `list_templates` | 템플릿 목록 |
| `get_template_info` | 템플릿 정보 |
| `apply_slide_layout` | 레이아웃 적용 |

### 구조 요소 (4개)

| 도구 | 기능 |
|------|------|
| `add_table` | 표 추가 |
| `add_shape` | 도형 추가 |
| `add_chart` | 차트 추가 |
| `manage_image` | 이미지 관리 |

### 전문 디자인 (3개)

| 도구 | 기능 |
|------|------|
| `apply_professional_design` | 전문가 디자인 적용 |
| `apply_picture_effects` | 9가지 이미지 효과 |
| `manage_fonts` | 폰트 관리 |

### 특화 기능 (5개)

| 도구 | 기능 |
|------|------|
| `add_hyperlink` | 하이퍼링크 추가 |
| `manage_slide_master` | 마스터 슬라이드 관리 |
| `add_connector` | 커넥터 추가 |
| `update_chart_data` | 차트 데이터 업데이트 |
| `add_transition` | 전환 효과 추가 |

---

## 25개 전문가 템플릿

### 비즈니스
- Executive Summary
- Sales Pitch
- Business Review
- Financial Report

### 기술
- Technical Architecture
- Product Demo
- Development Sprint
- System Overview

### 교육
- Training Module
- Workshop
- Course Overview
- Lecture

### 마케팅
- Marketing Plan
- Campaign Review
- Brand Guidelines
- Product Launch

---

## 설치 방법

### Smithery (권장)

```bash
npx -y @smithery/cli install @GongRzhe/Office-PowerPoint-MCP-Server --client claude
```

### pip 설치

```bash
pip install office-powerpoint-mcp-server
```

### 수동 설치

```bash
git clone https://github.com/GongRzhe/Office-PowerPoint-MCP-Server
cd Office-PowerPoint-MCP-Server
pip install -r requirements.txt
python setup_mcp.py
```

### Claude Desktop 설정

```json
{
  "mcpServers": {
    "powerpoint": {
      "command": "uvx",
      "args": ["office-powerpoint-mcp-server"]
    }
  }
}
```

---

## 사용 예시

### 프레젠테이션 생성

```
"AI 트렌드 2026" 주제로 10페이지 프레젠테이션 만들어줘
→ 자동 생성 + 전문가 디자인 적용
```

### 템플릿 적용

```
이 PPT에 Executive Summary 템플릿을 적용해줘
→ 템플릿 스타일로 변환
```

### 차트 추가

```
이 데이터로 슬라이드에 막대 차트를 추가해줘
→ 차트 생성 및 데이터 바인딩
```

---

## 장단점

### 장점
- API 키 불필요 (완전 로컬 실행)
- 32개 도구로 포괄적 기능
- 25개 전문가 템플릿
- 1.5K 스타의 활발한 프로젝트
- Python 기반 (커스터마이징 용이)

### 단점/주의사항
- Python 환경 필요
- Windows에서 주로 테스트됨
- 복잡한 애니메이션은 제한적

---

## 관련 리소스

- [python-pptx 라이브러리](https://python-pptx.readthedocs.io/)
- [Open XML SDK](https://docs.microsoft.com/office/open-xml/open-xml-sdk)

---

**문서 작성일:** 2026-01-28
