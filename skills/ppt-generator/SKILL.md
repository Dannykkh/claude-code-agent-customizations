---
name: ppt-generator
description: Python python-pptx 기반 PPT 생성 스킬. 템플릿 활용, 마크다운/JSON 입력, 차트/표/이미지 지원.
---

# PPT Generator

python-pptx를 활용하여 템플릿 기반의 전문적인 PowerPoint 프레젠테이션을 생성합니다.

## 사용법

```
/ppt-generator 분기별 실적 보고서 PPT 만들어줘
/ppt-generator --template company.pptx 신제품 소개 자료
/ppt-generator 이 마크다운 내용으로 PPT 생성해줘
```

## 요구사항

```bash
pip install python-pptx Pillow
```

## 템플릿 구조

```
templates/
├── default.pptx          # 기본 템플릿
├── corporate.pptx        # 회사 브랜드 템플릿
├── pitch-deck.pptx       # 투자자 피칭용
├── report.pptx           # 보고서용
└── minimal.pptx          # 미니멀 스타일
```

## 핵심 코드

### 1. 기본 PPT 생성

```python
from pptx import Presentation
from pptx.util import Inches, Pt, Emu
from pptx.dml.color import RgbColor
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from pptx.enum.shapes import MSO_SHAPE
from pathlib import Path

class PPTGenerator:
    """템플릿 기반 PPT 생성기"""

    def __init__(self, template_path: str | None = None):
        """
        Args:
            template_path: 템플릿 파일 경로. None이면 빈 PPT 생성
        """
        if template_path and Path(template_path).exists():
            self.prs = Presentation(template_path)
        else:
            self.prs = Presentation()

        self._setup_slide_layouts()

    def _setup_slide_layouts(self):
        """슬라이드 레이아웃 매핑"""
        self.layouts = {
            'title': 0,           # 제목 슬라이드
            'title_content': 1,   # 제목 + 내용
            'section': 2,         # 섹션 헤더
            'two_content': 3,     # 2단 레이아웃
            'comparison': 4,      # 비교
            'title_only': 5,      # 제목만
            'blank': 6,           # 빈 슬라이드
            'content_caption': 7, # 내용 + 캡션
            'picture_caption': 8, # 그림 + 캡션
        }

    def add_title_slide(self, title: str, subtitle: str = ""):
        """제목 슬라이드 추가"""
        layout = self.prs.slide_layouts[self.layouts['title']]
        slide = self.prs.slides.add_slide(layout)

        slide.shapes.title.text = title
        if subtitle and len(slide.placeholders) > 1:
            slide.placeholders[1].text = subtitle

        return slide

    def add_content_slide(self, title: str, bullets: list[str]):
        """제목 + 글머리 기호 슬라이드"""
        layout = self.prs.slide_layouts[self.layouts['title_content']]
        slide = self.prs.slides.add_slide(layout)

        slide.shapes.title.text = title

        body = slide.placeholders[1]
        tf = body.text_frame
        tf.clear()

        for i, bullet in enumerate(bullets):
            if i == 0:
                tf.paragraphs[0].text = bullet
            else:
                p = tf.add_paragraph()
                p.text = bullet
                p.level = 0

        return slide

    def add_two_column_slide(self, title: str, left: list[str], right: list[str]):
        """2단 레이아웃 슬라이드"""
        layout = self.prs.slide_layouts[self.layouts['two_content']]
        slide = self.prs.slides.add_slide(layout)

        slide.shapes.title.text = title

        # 왼쪽 컬럼
        left_placeholder = slide.placeholders[1]
        tf = left_placeholder.text_frame
        tf.clear()
        for i, text in enumerate(left):
            if i == 0:
                tf.paragraphs[0].text = text
            else:
                p = tf.add_paragraph()
                p.text = text

        # 오른쪽 컬럼
        right_placeholder = slide.placeholders[2]
        tf = right_placeholder.text_frame
        tf.clear()
        for i, text in enumerate(right):
            if i == 0:
                tf.paragraphs[0].text = text
            else:
                p = tf.add_paragraph()
                p.text = text

        return slide

    def add_image_slide(self, title: str, image_path: str, caption: str = ""):
        """이미지 슬라이드"""
        layout = self.prs.slide_layouts[self.layouts['title_only']]
        slide = self.prs.slides.add_slide(layout)

        slide.shapes.title.text = title

        # 이미지 추가 (중앙 배치)
        img_left = Inches(1.5)
        img_top = Inches(2)
        img_width = Inches(7)

        slide.shapes.add_picture(image_path, img_left, img_top, width=img_width)

        # 캡션 추가
        if caption:
            txBox = slide.shapes.add_textbox(
                Inches(1), Inches(6.5), Inches(8), Inches(0.5)
            )
            tf = txBox.text_frame
            tf.paragraphs[0].text = caption
            tf.paragraphs[0].alignment = PP_ALIGN.CENTER

        return slide

    def save(self, output_path: str):
        """PPT 저장"""
        self.prs.save(output_path)
        print(f"PPT 저장 완료: {output_path}")
```

### 2. 표 추가

```python
from pptx.util import Inches, Pt

def add_table_slide(self, title: str, headers: list[str], rows: list[list[str]]):
    """표가 포함된 슬라이드"""
    layout = self.prs.slide_layouts[self.layouts['title_only']]
    slide = self.prs.slides.add_slide(layout)

    slide.shapes.title.text = title

    # 표 크기 계산
    cols = len(headers)
    row_count = len(rows) + 1  # 헤더 포함

    # 표 추가
    left = Inches(0.5)
    top = Inches(2)
    width = Inches(9)
    height = Inches(0.4 * row_count)

    table = slide.shapes.add_table(
        row_count, cols, left, top, width, height
    ).table

    # 헤더 스타일
    for i, header in enumerate(headers):
        cell = table.cell(0, i)
        cell.text = header
        cell.fill.solid()
        cell.fill.fore_color.rgb = RgbColor(0x2E, 0x75, 0xB6)  # 파란색

        para = cell.text_frame.paragraphs[0]
        para.font.bold = True
        para.font.color.rgb = RgbColor(0xFF, 0xFF, 0xFF)  # 흰색
        para.font.size = Pt(12)

    # 데이터 행
    for row_idx, row_data in enumerate(rows):
        for col_idx, cell_text in enumerate(row_data):
            cell = table.cell(row_idx + 1, col_idx)
            cell.text = str(cell_text)

            para = cell.text_frame.paragraphs[0]
            para.font.size = Pt(11)

    return slide
```

### 3. 차트 추가

```python
from pptx.chart.data import CategoryChartData
from pptx.enum.chart import XL_CHART_TYPE

def add_chart_slide(
    self,
    title: str,
    chart_type: str,
    categories: list[str],
    series_data: dict[str, list[float]]
):
    """차트 슬라이드

    Args:
        title: 슬라이드 제목
        chart_type: 'bar', 'line', 'pie', 'column'
        categories: X축 카테고리
        series_data: {"시리즈명": [값들]}
    """
    layout = self.prs.slide_layouts[self.layouts['title_only']]
    slide = self.prs.slides.add_slide(layout)

    slide.shapes.title.text = title

    # 차트 데이터 준비
    chart_data = CategoryChartData()
    chart_data.categories = categories

    for series_name, values in series_data.items():
        chart_data.add_series(series_name, values)

    # 차트 타입 매핑
    chart_types = {
        'bar': XL_CHART_TYPE.BAR_CLUSTERED,
        'column': XL_CHART_TYPE.COLUMN_CLUSTERED,
        'line': XL_CHART_TYPE.LINE,
        'pie': XL_CHART_TYPE.PIE,
        'area': XL_CHART_TYPE.AREA,
        'doughnut': XL_CHART_TYPE.DOUGHNUT,
    }

    xl_chart_type = chart_types.get(chart_type, XL_CHART_TYPE.COLUMN_CLUSTERED)

    # 차트 추가
    x, y, cx, cy = Inches(1), Inches(2), Inches(8), Inches(4.5)
    chart = slide.shapes.add_chart(
        xl_chart_type, x, y, cx, cy, chart_data
    ).chart

    # 범례 위치 조정
    chart.has_legend = True
    chart.legend.include_in_layout = False

    return slide
```

### 4. 마크다운 → PPT 변환

```python
import re

def markdown_to_slides(self, markdown_text: str):
    """마크다운 텍스트를 슬라이드로 변환

    지원 형식:
    # 제목 슬라이드
    ## 섹션 제목
    - 글머리 기호
    ![이미지](path.png)
    | 표 | 헤더 |
    """
    lines = markdown_text.strip().split('\n')
    current_slide = None
    current_bullets = []
    current_title = ""

    for line in lines:
        line = line.strip()

        # 제목 슬라이드 (# )
        if line.startswith('# ') and not line.startswith('## '):
            if current_title and current_bullets:
                self.add_content_slide(current_title, current_bullets)
                current_bullets = []

            title = line[2:]
            self.add_title_slide(title)
            current_title = ""

        # 섹션/콘텐츠 제목 (## )
        elif line.startswith('## '):
            if current_title and current_bullets:
                self.add_content_slide(current_title, current_bullets)
                current_bullets = []

            current_title = line[3:]

        # 글머리 기호 (- 또는 * )
        elif line.startswith('- ') or line.startswith('* '):
            bullet = line[2:]
            current_bullets.append(bullet)

        # 숫자 목록 (1. )
        elif re.match(r'^\d+\. ', line):
            bullet = re.sub(r'^\d+\. ', '', line)
            current_bullets.append(bullet)

        # 구분선 (---) = 새 슬라이드
        elif line == '---':
            if current_title and current_bullets:
                self.add_content_slide(current_title, current_bullets)
                current_bullets = []
                current_title = ""

    # 마지막 슬라이드
    if current_title and current_bullets:
        self.add_content_slide(current_title, current_bullets)
```

### 5. JSON → PPT 변환

```python
import json

def json_to_slides(self, json_data: str | dict):
    """JSON 데이터를 슬라이드로 변환

    JSON 형식:
    {
        "title": "프레젠테이션 제목",
        "subtitle": "부제목",
        "slides": [
            {
                "type": "content",
                "title": "슬라이드 제목",
                "bullets": ["항목1", "항목2"]
            },
            {
                "type": "table",
                "title": "표 슬라이드",
                "headers": ["헤더1", "헤더2"],
                "rows": [["값1", "값2"]]
            },
            {
                "type": "chart",
                "title": "차트 슬라이드",
                "chart_type": "bar",
                "categories": ["Q1", "Q2", "Q3"],
                "series": {"매출": [100, 150, 200]}
            }
        ]
    }
    """
    if isinstance(json_data, str):
        data = json.loads(json_data)
    else:
        data = json_data

    # 제목 슬라이드
    self.add_title_slide(
        data.get('title', 'Presentation'),
        data.get('subtitle', '')
    )

    # 각 슬라이드 생성
    for slide_data in data.get('slides', []):
        slide_type = slide_data.get('type', 'content')

        if slide_type == 'content':
            self.add_content_slide(
                slide_data['title'],
                slide_data.get('bullets', [])
            )

        elif slide_type == 'two_column':
            self.add_two_column_slide(
                slide_data['title'],
                slide_data.get('left', []),
                slide_data.get('right', [])
            )

        elif slide_type == 'table':
            self.add_table_slide(
                slide_data['title'],
                slide_data['headers'],
                slide_data['rows']
            )

        elif slide_type == 'chart':
            self.add_chart_slide(
                slide_data['title'],
                slide_data.get('chart_type', 'column'),
                slide_data['categories'],
                slide_data['series']
            )

        elif slide_type == 'image':
            self.add_image_slide(
                slide_data['title'],
                slide_data['image_path'],
                slide_data.get('caption', '')
            )
```

## 전체 사용 예시

### 예시 1: 마크다운에서 PPT 생성

```python
markdown_content = """
# 2026년 분기별 실적 보고서

## 1분기 실적 요약
- 매출: 150억원 (전년 대비 20% 증가)
- 영업이익: 30억원
- 신규 고객: 1,500명

## 주요 성과
- 신규 서비스 런칭 성공
- 고객 만족도 95% 달성
- 해외 시장 진출 준비 완료

## 2분기 계획
- 동남아 시장 진출
- 신규 기능 3종 출시
- 파트너십 확대
"""

# 템플릿 사용
ppt = PPTGenerator('templates/corporate.pptx')
ppt.markdown_to_slides(markdown_content)
ppt.save('실적보고서.pptx')
```

### 예시 2: JSON에서 차트 포함 PPT

```python
presentation_data = {
    "title": "매출 분석 리포트",
    "subtitle": "2026년 1분기",
    "slides": [
        {
            "type": "content",
            "title": "Executive Summary",
            "bullets": [
                "전체 매출 20% 성장",
                "신규 고객 1,500명 확보",
                "고객 이탈률 5% 감소"
            ]
        },
        {
            "type": "chart",
            "title": "분기별 매출 추이",
            "chart_type": "column",
            "categories": ["Q1 2025", "Q2 2025", "Q3 2025", "Q4 2025", "Q1 2026"],
            "series": {
                "매출": [100, 120, 130, 145, 175],
                "목표": [100, 110, 120, 130, 150]
            }
        },
        {
            "type": "table",
            "title": "제품별 실적",
            "headers": ["제품", "매출", "성장률", "점유율"],
            "rows": [
                ["제품 A", "80억", "+25%", "45%"],
                ["제품 B", "50억", "+15%", "30%"],
                ["제품 C", "45억", "+10%", "25%"]
            ]
        }
    ]
}

ppt = PPTGenerator('templates/report.pptx')
ppt.json_to_slides(presentation_data)
ppt.save('매출분석.pptx')
```

## 템플릿 팁

### 좋은 템플릿 만드는 법

1. **마스터 슬라이드 정의**
   - PowerPoint에서 보기 → 슬라이드 마스터
   - 각 레이아웃에 플레이스홀더 배치
   - 색상 테마, 폰트 설정

2. **플레이스홀더 활용**
   ```
   Layout 0: 제목 슬라이드 (Title, Subtitle)
   Layout 1: 제목+내용 (Title, Body)
   Layout 2: 섹션 헤더
   Layout 3: 2단 (Title, Left, Right)
   Layout 5: 제목만 (이미지/차트용)
   Layout 6: 빈 슬라이드
   ```

3. **브랜드 요소 포함**
   - 로고 위치 고정
   - 푸터 (페이지 번호, 날짜)
   - 색상 팔레트 정의

### 무료 템플릿 소스

- [SlidesCarnival](https://www.slidescarnival.com/) - 무료 Google Slides/PPT
- [SlidesGo](https://slidesgo.com/) - Canva 스타일 템플릿
- [FPPT](https://www.free-power-point-templates.com/) - 비즈니스 템플릿

## 체크리스트

- [ ] python-pptx 설치됨
- [ ] 템플릿 파일 준비 (`templates/` 폴더)
- [ ] 이미지 경로 확인 (절대 경로 권장)
- [ ] 한글 폰트 지원 확인
- [ ] 출력 경로 쓰기 권한 확인

## 관련 명령어

- `/ppt-generator` - 이 스킬 실행
- `/erd-designer` - ERD 다이어그램 생성 (Mermaid)
- `/docker-deploy` - 배포 환경 구성
