# Humanizer Skill

AI가 쓴 티가 나는 글을 사람이 쓴 것처럼 자연스럽게 바꿔주는 Claude Code 스킬입니다.

## 출처

이 스킬은 [blader/humanizer](https://github.com/blader/humanizer)를 기반으로 합니다.

Wikipedia의 [Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing) 가이드를 참고하여 24가지 AI 글쓰기 패턴을 감지하고 수정합니다.

## 감지하는 패턴들

### Content Patterns
- 과장된 중요성 강조 (pivotal moment, testament, evolving landscape)
- 주목받음 과시 (media coverage 나열)
- 표면적인 -ing 분석 (highlighting, showcasing, reflecting)
- 광고성 언어 (vibrant, nestled, groundbreaking)
- 모호한 출처 (Experts argue, Industry reports)
- "Challenges and Future" 섹션

### Language Patterns
- AI 특유 어휘 (Additionally, delve, foster, landscape)
- is/are 회피 (serves as, stands as)
- 부정 병렬 구조 (It's not just X, it's Y)
- 3의 법칙 남용
- 동의어 돌려쓰기
- 의미없는 범위 표현 (from X to Y)

### Style Patterns
- Em dash 남용
- 과도한 굵은 글씨
- 인라인 헤더 목록
- 제목 대문자화
- 이모지 장식
- 곡선 따옴표

### Communication Patterns
- 챗봇 흔적 (I hope this helps!, Great question!)
- 지식 컷오프 면책 조항
- 아부성 어조
- 불필요한 완충어
- 과도한 헤징
- 뻔한 긍정 결론

## 사용법

Claude Code에서:
```
/humanizer [휴머나이즈할 텍스트]
```

또는:
```
이 텍스트 휴머나이즈 해줘: [텍스트]
```

## 설치

이 저장소의 `skills/humanizer` 폴더를 `~/.claude/skills/` 에 복사하거나 심볼릭 링크를 생성합니다.

```bash
# Windows
mklink /D "%USERPROFILE%\.claude\skills\humanizer" "이 저장소 경로\skills\humanizer"

# Linux/Mac
ln -s "이 저장소 경로/skills/humanizer" ~/.claude/skills/humanizer
```
