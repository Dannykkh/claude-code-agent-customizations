---
description: API 엔드포인트 문서 생성
allowed-tools: Read, Write, Glob, Grep, Bash
---

# API 문서 생성 가이드

FastAPI 라우터를 분석하여 API 문서를 자동 생성합니다.

## 분석 대상
- `backend/app/api/v1/*.py` 파일의 라우터 함수
- Pydantic 스키마 (`backend/app/schemas/*.py`)
- 의존성 주입 (`backend/app/api/deps.py`)

## 출력 구조

```markdown
# [API 그룹명] API

## 개요
[API 그룹 설명]

---

## Endpoint: [METHOD] /api/v1/[path]

### Description
[엔드포인트 설명]

### Authentication
- Required: Yes/No
- Header: `X-API-Key: <your-api-key>`

### Request

#### Headers
| Name | Required | Description |
|------|----------|-------------|
| X-API-Key | Yes | API 인증 키 |

#### Query Parameters
| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| search | string | Yes | - | 검색어 |
| version | string | No | "1.0" | API 버전 |

#### Request Body (JSON)
```json
{
  "field1": "value1",
  "field2": "value2"
}
```

### Response

#### 200 OK
```json
{
  "status": "success",
  "data": [...]
}
```

#### 400 Bad Request
```json
{
  "status": "error",
  "message": "Invalid parameter",
  "code": "INVALID_PARAM"
}
```

#### 401 Unauthorized
```json
{
  "status": "error",
  "message": "Invalid API key",
  "code": "UNAUTHORIZED"
}
```

### Example

#### cURL
```bash
curl -X GET "http://localhost:8000/api/v1/users/search?search=john&version=1.0" \
  -H "X-API-Key: your-api-key"
```

#### Python
```python
import httpx

response = httpx.get(
    "http://localhost:8000/api/v1/users/search",
    params={"search": "john", "version": "1.0"},
    headers={"X-API-Key": "your-api-key"}
)
print(response.json())
```
```

## 출력 위치
`docs/api/[endpoint-group].md`

## 실행 예시
```
/write-api-docs users
/write-api-docs products
/write-api-docs admin
```
