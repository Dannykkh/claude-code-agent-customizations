# Generate: $ARGUMENTS

코드를 자동 생성합니다.

## 사용법
```
/generate name:string,age:number           # DTO 생성
/generate entity Item                      # Entity + Repository 생성
/generate api /items                       # API 관련 전체 생성
/generate component ItemCard               # React 컴포넌트 생성
/generate hook useItems                    # React 훅 생성
```

## 생성 유형

### 1. DTO 생성
```
/generate name:string,price:number,category:string,createdAt:datetime
```

**생성 파일:**
- `CreateRequest.java`
- `UpdateRequest.java`
- `Response.java`
- `ListResponse.java`

```java
// CreateRequest.java
public record CreateRequest(
    @NotBlank String name,
    @NotNull @Positive Integer price,
    @NotBlank String category
) {}

// Response.java
public record Response(
    Long id,
    String name,
    Integer price,
    String category,
    LocalDateTime createdAt
) {
    public static Response from(Entity entity) {
        return new Response(
            entity.getId(),
            entity.getName(),
            entity.getPrice(),
            entity.getCategory(),
            entity.getCreatedAt()
        );
    }
}
```

### 2. Entity 생성
```
/generate entity Item
```

**생성 파일:**
- `Item.java` (Entity)
- `ItemRepository.java`

```java
@Entity
@Table(name = "item")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Item extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private Integer price;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ItemStatus status = ItemStatus.ACTIVE;

    @Builder
    public Item(String name, Integer price) {
        this.name = name;
        this.price = price;
    }

    public static Item from(ItemCreateRequest request) {
        return Item.builder()
            .name(request.name())
            .price(request.price())
            .build();
    }
}
```

### 3. API 전체 생성
```
/generate api /items
```

**생성 파일:**
- `dto/ItemCreateRequest.java`
- `dto/ItemUpdateRequest.java`
- `dto/ItemResponse.java`
- `dto/ItemListResponse.java`
- `service/ItemService.java`
- `service/ItemServiceImpl.java`
- `controller/ItemController.java`
- `ItemControllerTest.java`
- `ItemServiceTest.java`

### 4. React 컴포넌트 생성
```
/generate component ItemCard
```

**생성 파일:**
- `components/ItemCard.tsx`
- `components/ItemCard.test.tsx`

```tsx
// ItemCard.tsx
import { useTranslation } from 'react-i18next';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import type { Item } from '../types';

interface ItemCardProps {
  item: Item;
  onClick?: (id: number) => void;
}

export function ItemCard({ item, onClick }: ItemCardProps) {
  const { t } = useTranslation();

  return (
    <Card
      className="cursor-pointer hover:shadow-md transition-shadow"
      onClick={() => onClick?.(item.id)}
    >
      <CardHeader>
        <CardTitle>{item.name}</CardTitle>
      </CardHeader>
      <CardContent>
        <Badge variant={getStatusVariant(item.status)}>
          {t(`status.${item.status.toLowerCase()}`)}
        </Badge>
      </CardContent>
    </Card>
  );
}

function getStatusVariant(status: string) {
  switch (status) {
    case 'ACTIVE': return 'success';
    case 'PENDING': return 'warning';
    case 'COMPLETED': return 'default';
    default: return 'secondary';
  }
}
```

### 5. React Hook 생성
```
/generate hook useItems
```

**생성 파일:**
- `hooks/useItems.ts`
- `hooks/useItems.test.ts`

```typescript
// useItems.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { itemApi } from '../api/item';
import type { ItemListParams, ItemCreateRequest } from '../types';

const QUERY_KEY = ['items'];

export function useItems(params?: ItemListParams) {
  return useQuery({
    queryKey: [...QUERY_KEY, params],
    queryFn: () => itemApi.getList(params),
  });
}

export function useItem(id: number) {
  return useQuery({
    queryKey: [...QUERY_KEY, id],
    queryFn: () => itemApi.getById(id),
    enabled: !!id,
  });
}

export function useCreateItem() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (data: ItemCreateRequest) => itemApi.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: QUERY_KEY });
    },
  });
}

export function useUpdateItem() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: ({ id, data }: { id: number; data: ItemUpdateRequest }) =>
      itemApi.update(id, data),
    onSuccess: (_, { id }) => {
      queryClient.invalidateQueries({ queryKey: QUERY_KEY });
      queryClient.invalidateQueries({ queryKey: [...QUERY_KEY, id] });
    },
  });
}

export function useDeleteItem() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (id: number) => itemApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: QUERY_KEY });
    },
  });
}
```

## 타입 매핑

| 입력 타입 | Java | TypeScript |
|----------|------|------------|
| string | String | string |
| number | Integer | number |
| long | Long | number |
| boolean | Boolean | boolean |
| date | LocalDate | string |
| datetime | LocalDateTime | string |
| email | String (@Email) | string |
| uuid | UUID | string |

## 출력

```markdown
# 🔧 코드 생성 완료

## 생성 요약
- **대상**: $ARGUMENTS
- **생성 파일**: N개

## 생성된 파일
1. `src/.../ItemCreateRequest.java`
2. `src/.../ItemResponse.java`
3. `frontend/src/.../useItems.ts`
...

## 다음 단계
1. 생성된 코드 확인
2. 비즈니스 로직 추가
3. 테스트 실행
```
