# mcp-pandoc

> 문서 형식 변환을 위한 Pandoc MCP 서버

## 기본 정보

| 항목 | 내용 |
|------|------|
| **저장소** | [github.com/vivekVells/mcp-pandoc](https://github.com/vivekVells/mcp-pandoc) |
| **제작자** | vivekVells |
| **라이선스** | MIT |
| **분류** | MCP 서버 |
| **API 키** | 불필요 (로컬 실행) |

---

## 개요

Pandoc을 활용한 문서 형식 변환 MCP 서버. Markdown, HTML, DOCX, PDF 등 10가지 형식 간 변환을 지원하며, 포맷팅과 구조를 보존합니다.

---

## 지원 포맷

### 기본 포맷 (추가 설정 불필요)

| 포맷 | 확장자 | 입력 | 출력 |
|------|--------|------|------|
| Markdown | `.md` | O | O |
| HTML | `.html` | O | O |
| Plain Text | `.txt` | O | O |
| Jupyter Notebook | `.ipynb` | O | O |
| OpenDocument | `.odt` | O | O |

### 고급 포맷 (출력 경로 필수)

| 포맷 | 확장자 | 입력 | 출력 | 비고 |
|------|--------|------|------|------|
| Word | `.docx` | O | O | |
| PDF | `.pdf` | X | O | **출력 전용** |
| reStructuredText | `.rst` | O | O | |
| LaTeX | `.tex` | O | O | |
| EPUB | `.epub` | O | O | |

> **주의:** PDF는 출력 전용입니다. PDF → 다른 형식 변환은 지원되지 않습니다.

---

## 설치 방법

### 1. 필수 요구사항

**Pandoc 설치:**
```bash
# macOS
brew install pandoc

# Ubuntu/Debian
sudo apt-get install pandoc

# Windows
choco install pandoc
```

**UV 패키지 관리자:**
```bash
# macOS
brew install uv

# Windows/Linux
pip install uv
```

**PDF 변환용 TeX Live (선택):**
```bash
# macOS
brew install texlive

# Ubuntu/Debian
sudo apt-get install texlive-xetex
```

### 2. MCP 서버 설정

```json
{
  "mcpServers": {
    "mcp-pandoc": {
      "command": "uvx",
      "args": ["mcp-pandoc"]
    }
  }
}
```

---

## 주요 기능

### 1. 양방향 변환

```
Markdown → HTML
HTML → DOCX
DOCX → PDF
```

### 2. Defaults 파일

YAML 기반 재사용 가능한 변환 템플릿:

```yaml
# defaults.yaml
from: markdown
to: pdf
pdf-engine: xelatex
variables:
  fontsize: 12pt
  geometry: margin=1in
```

### 3. 참조 문서

DOCX 출력 시 스타일 템플릿 적용:

```
--reference-doc=template.docx
```

---

## 사용 예시

### Markdown → PDF

```
이 Markdown 파일을 PDF로 변환해줘
→ /path/to/output.pdf로 저장
```

### HTML → DOCX

```
이 웹페이지를 Word 문서로 변환해줘
→ 포맷팅 유지하면서 DOCX 생성
```

### Jupyter → Markdown

```
이 노트북을 Markdown으로 변환해줘
→ 코드 블록과 출력 유지
```

### 일괄 변환

```
docs 폴더의 모든 .md 파일을 PDF로 변환해줘
→ 각 파일별 PDF 생성
```

---

## 장단점

### 장점
- 10가지 포맷 지원
- API 키 불필요 (완전 로컬)
- Pandoc의 강력한 변환 엔진
- 스타일 템플릿 지원 (DOCX)
- 수식, 코드 블록 지원

### 단점/주의사항
- Pandoc 사전 설치 필요
- PDF 출력은 TeX Live 필요
- PDF → 다른 형식 변환 불가
- 복잡한 레이아웃은 손실 가능

---

## 관련 리소스

- [Pandoc 공식 문서](https://pandoc.org/MANUAL.html)
- [TeX Live](https://tug.org/texlive/)

---

**문서 작성일:** 2026-01-28
