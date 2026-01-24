# Claude Code Orchestrator MCP Server

PM + Worker 병렬 처리를 위한 MCP 서버입니다.

## 설치

```bash
cd claude-orchestrator-mcp
npm install
npm run build
```

## 실행 방법

### 1. PowerShell 스크립트 사용 (권장)

```powershell
# 기본 실행 (3개 Worker, 자동 모드)
.\scripts\launch.ps1 -ProjectPath "C:\your\project"

# Worker 수 지정
.\scripts\launch.ps1 -ProjectPath "C:\your\project" -WorkerCount 5

# 수동 모드 (권한 확인 필요)
.\scripts\launch.ps1 -ProjectPath "C:\your\project" -ManualMode

# Git Worktree 없이 실행
.\scripts\launch.ps1 -ProjectPath "C:\your\project" -SkipWorktrees

# 클린 스타트 (기존 데이터 삭제)
.\scripts\launch.ps1 -ProjectPath "C:\your\project" -CleanStart
```

**실행 모드:**
- **자동 모드** (기본): `claude --dangerously-skip-permissions`로 실행, 권한 확인 없이 자동 작업
- **수동 모드** (`-ManualMode`): 일반 `claude`로 실행, 각 작업마다 권한 확인 필요

### 2. 수동 설정

`.claude/mcp.json` 파일을 프로젝트 루트에 생성:

```json
{
  "mcpServers": {
    "orchestrator": {
      "command": "node",
      "args": ["path/to/claude-orchestrator-mcp/dist/index.js"],
      "env": {
        "ORCHESTRATOR_PROJECT_ROOT": "C:\\your\\project",
        "ORCHESTRATOR_WORKER_ID": "pm"
      }
    }
  }
}
```

Worker는 `ORCHESTRATOR_WORKER_ID`를 `worker-1`, `worker-2` 등으로 변경하여 설정합니다.

## MCP 도구

### PM 전용 도구

| 도구 | 설명 |
|------|------|
| `orchestrator_analyze_codebase` | 프로젝트 구조 분석 |
| `orchestrator_create_task` | 태스크 생성 |
| `orchestrator_get_progress` | 진행 상황 조회 |

### Worker 전용 도구

| 도구 | 설명 |
|------|------|
| `orchestrator_get_available_tasks` | 가용 태스크 목록 조회 |
| `orchestrator_claim_task` | 태스크 담당 선언 |
| `orchestrator_lock_file` | 파일/폴더 락 획득 |
| `orchestrator_unlock_file` | 파일/폴더 락 해제 |
| `orchestrator_complete_task` | 태스크 완료 처리 |
| `orchestrator_fail_task` | 태스크 실패 처리 |

### 공통 도구

| 도구 | 설명 |
|------|------|
| `orchestrator_get_status` | 전체 시스템 상태 조회 |
| `orchestrator_get_task` | 특정 태스크 상세 조회 |
| `orchestrator_get_file_locks` | 현재 파일 락 목록 |
| `orchestrator_delete_task` | 태스크 삭제 |
| `orchestrator_reset` | 상태 초기화 |
| `orchestrator_heartbeat` | 워커 하트비트 갱신 |

## 워크플로우 예시

### PM

```
1. orchestrator_analyze_codebase() - 프로젝트 분석
2. orchestrator_create_task({id: "task-1", prompt: "...", priority: 2})
3. orchestrator_create_task({id: "task-2", prompt: "...", depends_on: ["task-1"]})
4. orchestrator_get_progress() - 진행 상황 모니터링
```

### Worker

```
1. orchestrator_get_available_tasks() - 가용 태스크 확인
2. orchestrator_claim_task({task_id: "task-1"}) - 태스크 담당
3. orchestrator_lock_file({path: "src/module"}) - 파일 락
4. (실제 작업 수행)
5. orchestrator_complete_task({task_id: "task-1", result: "완료"})
```

## 상태 파일

오케스트레이터 상태는 `{프로젝트}/.orchestrator/state.json`에 저장됩니다.

```json
{
  "tasks": [...],
  "fileLocks": [...],
  "workers": [...],
  "projectRoot": "...",
  "startedAt": "...",
  "version": "1.0.0"
}
```
