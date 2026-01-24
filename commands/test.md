# Test: $ARGUMENTS

테스트 코드를 생성하고 실행합니다.

## 사용법
```
/test                    # 전체 테스트 실행
/test 80                 # 목표 커버리지 80%로 테스트 생성
/test ItemController     # 특정 클래스 테스트
/test frontend           # 프론트엔드 테스트만
/test backend            # 백엔드 테스트만
```

## 테스트 실행

### 백엔드

```bash
# 전체 테스트
cd backend
./gradlew test
# 또는
mvn test

# 특정 테스트
./gradlew test --tests "*ItemControllerTest*"

# 커버리지 리포트
./gradlew jacocoTestReport
# 결과: build/reports/jacoco/test/html/index.html
```

### 프론트엔드

```bash
# 전체 테스트
cd frontend
npm run test

# 워치 모드
npm run test -- --watch

# 커버리지
npm run test -- --coverage
```

## 테스트 생성 템플릿

### Controller 테스트 (Spring)

```java
@WebMvcTest(ItemController.class)
class ItemControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ItemService itemService;

    @Test
    @DisplayName("아이템 목록 조회 성공")
    void listItems_Success() throws Exception {
        // Given
        given(itemService.findAll(any()))
            .willReturn(Page.empty());

        // When & Then
        mockMvc.perform(get("/api/v1/items"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    @DisplayName("아이템 생성 - 유효성 검증 실패")
    void createItem_ValidationFail() throws Exception {
        // Given
        ItemCreateRequest request = new ItemCreateRequest("", null);

        // When & Then
        mockMvc.perform(post("/api/v1/items")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
            .andExpect(status().isBadRequest());
    }
}
```

### Service 테스트 (Spring)

```java
@ExtendWith(MockitoExtension.class)
class ItemServiceTest {

    @Mock
    private ItemRepository itemRepository;

    @InjectMocks
    private ItemServiceImpl itemService;

    @Test
    @DisplayName("아이템 생성 성공")
    void createItem_Success() {
        // Given
        ItemCreateRequest request = new ItemCreateRequest(
            "상품A", 10000
        );

        given(itemRepository.save(any()))
            .willReturn(Item.builder().id(1L).build());

        // When
        ItemResponse result = itemService.create(request);

        // Then
        assertThat(result.id()).isEqualTo(1L);
        verify(itemRepository).save(any());
    }
}
```

### React 컴포넌트 테스트

```typescript
import { render, screen } from '@testing-library/react';
import { ItemList } from './ItemList';

describe('ItemList', () => {
  it('renders item list correctly', () => {
    const items = [
      { id: 1, name: '상품A', status: 'ACTIVE' },
    ];

    render(<ItemList items={items} />);

    expect(screen.getByText('상품A')).toBeInTheDocument();
  });

  it('shows empty message when no items', () => {
    render(<ItemList items={[]} />);

    expect(screen.getByText(/no items/i)).toBeInTheDocument();
  });
});
```

### React Hook 테스트

```typescript
import { renderHook, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { useItems } from './useItems';

const wrapper = ({ children }) => (
  <QueryClientProvider client={new QueryClient()}>
    {children}
  </QueryClientProvider>
);

describe('useItems', () => {
  it('fetches items successfully', async () => {
    const { result } = renderHook(() => useItems(), { wrapper });

    await waitFor(() => {
      expect(result.current.isSuccess).toBe(true);
    });

    expect(result.current.data).toBeDefined();
  });
});
```

## 커버리지 목표

| 레이어 | 최소 커버리지 | 권장 커버리지 |
|--------|-------------|-------------|
| Controller | 80% | 90% |
| Service | 80% | 90% |
| Repository | 70% | 80% |
| Components | 70% | 80% |
| Hooks | 80% | 90% |
| Utils | 90% | 100% |

## 테스트 작성 원칙

### 1. Given-When-Then 패턴
```java
@Test
void testName() {
    // Given - 테스트 준비

    // When - 실행

    // Then - 검증
}
```

### 2. 테스트 명명 규칙
```
methodName_StateUnderTest_ExpectedBehavior

예:
createItem_ValidRequest_ReturnsCreatedItem
createItem_DuplicateName_ThrowsException
```

### 3. Edge Case 커버
- 정상 케이스
- 빈 값
- 경계값
- 에러 케이스
- 권한 검증

## 출력

```markdown
# 🧪 테스트 결과

## 실행 요약
- **실행 시간**: 2024-01-01 10:00:00
- **대상**: $ARGUMENTS

## 백엔드
| 항목 | 결과 |
|------|------|
| 테스트 수 | 120 |
| 성공 | 118 |
| 실패 | 2 |
| 커버리지 | 78% |

## 프론트엔드
| 항목 | 결과 |
|------|------|
| 테스트 수 | 45 |
| 성공 | 45 |
| 커버리지 | 72% |

## 실패한 테스트
1. ItemControllerTest.createItem_ValidationFail
   - 원인: 검증 메시지 변경됨

## 커버리지 미달 영역
- ItemService: 65% (목표: 80%)
  - createBulkItems 메서드 미테스트
```
