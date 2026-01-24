# Review: $ARGUMENTS

코드 리뷰를 수행합니다.

## 사용법
```
/review                  # 전체 변경사항 리뷰
/review security         # 보안 중심 리뷰
/review performance      # 성능 중심 리뷰
/review Item             # 특정 모듈 리뷰
```

## 리뷰 유형

### 1. 일반 리뷰 (기본)
```
/review
```
- 코드 스타일
- 아키텍처 준수
- 테스트 커버리지
- 문서화 상태

### 2. 보안 리뷰
```
/review security
```
**체크리스트:**
- [ ] SQL Injection 방지
- [ ] XSS 방지
- [ ] CSRF 방지
- [ ] 인증/인가 처리
- [ ] 민감 데이터 암호화
- [ ] 민감 정보 로깅 금지
- [ ] 입력값 검증
- [ ] 에러 메시지 정보 노출

### 3. 성능 리뷰
```
/review performance
```
**체크리스트:**
- [ ] N+1 쿼리 문제
- [ ] 불필요한 데이터 조회
- [ ] 인덱스 활용
- [ ] 캐싱 적용
- [ ] 페이지네이션 적용
- [ ] 번들 사이즈 최적화
- [ ] 메모이제이션 활용

## 리뷰 프로세스

```bash
# 1. 변경 사항 확인
git diff --name-only main

# 2. 변경 통계
git diff --stat main

# 3. 상세 변경 내용
git diff main
```

## 리뷰 기준

### 백엔드

#### Controller
```java
// ✅ 좋은 예
@RestController
@RequestMapping("/api/v1/items")
@RequiredArgsConstructor
public class ItemController {
    private final ItemService itemService;

    @GetMapping("/{id}")
    public ApiResponse<ItemResponse> getById(
            @PathVariable @Positive Long id) {
        return ApiResponse.success(itemService.findById(id));
    }
}

// ❌ 나쁜 예
@Controller  // @RestController 아님
public class ItemController {
    @Autowired ItemService service;  // 필드 주입

    @GetMapping("/items/{id}")  // /api/v1 누락
    public Item getById(Long id) {  // Entity 직접 반환
        return service.findById(id);
    }
}
```

#### Service
```java
// ✅ 좋은 예
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ItemServiceImpl implements ItemService {

    @Override
    @Transactional
    public ItemResponse create(ItemCreateRequest request) {
        Item item = Item.from(request);
        return ItemResponse.from(itemRepository.save(item));
    }
}
```

### 프론트엔드

#### 컴포넌트
```tsx
// ✅ 좋은 예
interface ItemCardProps {
  item: Item;
  onSelect?: (id: number) => void;
}

export function ItemCard({ item, onSelect }: ItemCardProps) {
  const { t } = useTranslation();

  return (
    <Card onClick={() => onSelect?.(item.id)}>
      <CardTitle>{item.name}</CardTitle>
      <Badge>{t(`status.${item.status}`)}</Badge>
    </Card>
  );
}

// ❌ 나쁜 예
export function ItemCard(props: any) {  // any 사용
  return (
    <div onClick={() => props.onSelect(props.item.id)}>
      <h2>{props.item.name}</h2>
      <span>활성</span>  {/* 하드코딩 */}
    </div>
  );
}
```

## 리뷰 결과 템플릿

```markdown
# 📝 코드 리뷰: $ARGUMENTS

## 요약
- **리뷰 유형**: 일반 / 보안 / 성능
- **변경 파일**: N개
- **결과**: ✅ APPROVE / 🔄 REQUEST CHANGES

## 상세 리뷰

### 👍 잘된 점
1. DTO 분리 잘됨
2. 테스트 커버리지 충분

### 🔧 수정 필요 (Must Fix)
1. **[파일:라인]** 문제 설명
   - 현재: ...
   - 수정: ...

### 💡 개선 제안 (Nice to Have)
1. **[파일:라인]** 제안 설명

## 보안 체크 (security 리뷰 시)
- [x] SQL Injection 방지
- [x] XSS 방지
- [ ] 입력값 검증 일부 누락

## 성능 체크 (performance 리뷰 시)
- [x] N+1 문제 없음
- [ ] 페이지네이션 미적용

## 최종 판정
[APPROVE/REQUEST CHANGES 사유]
```

## 자동 호출

리뷰 완료 후 자동으로:
1. `@code-reviewer` 서브에이전트로 상세 리뷰
2. `@qa-agent` 결과 참조
3. PR 생성 가능 여부 판단
