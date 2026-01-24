#!/bin/bash
# ============================================
#   Claude Code Customizations Installer
#   Skills, Agents, Commands, Hooks 설치 스크립트
# ============================================

echo ""
echo "============================================"
echo "  Claude Code Customizations Installer"
echo "============================================"
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# Claude 폴더 확인
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "[오류] Claude Code가 설치되어 있지 않습니다."
    echo "       $CLAUDE_DIR 폴더를 찾을 수 없습니다."
    exit 1
fi

# Skills 설치 (글로벌)
echo "[1/4] Skills 설치 중... (글로벌)"
if [ -d "$SCRIPT_DIR/skills" ]; then
    for skill_dir in "$SCRIPT_DIR/skills"/*/; do
        if [ -d "$skill_dir" ]; then
            skill_name=$(basename "$skill_dir")
            echo "      - $skill_name"
            mkdir -p "$CLAUDE_DIR/skills/$skill_name"
            cp -r "$skill_dir"* "$CLAUDE_DIR/skills/$skill_name/"
        fi
    done
    echo "      완료!"
else
    echo "      스킬 없음"
fi

# Agents 설치 (글로벌)
echo ""
echo "[2/4] Agents 설치 중... (글로벌)"
if [ -d "$SCRIPT_DIR/agents" ] && [ "$(ls -A "$SCRIPT_DIR/agents"/*.md 2>/dev/null)" ]; then
    mkdir -p "$CLAUDE_DIR/agents"
    for agent_file in "$SCRIPT_DIR/agents"/*.md; do
        if [ -f "$agent_file" ]; then
            echo "      - $(basename "$agent_file")"
            cp "$agent_file" "$CLAUDE_DIR/agents/"
        fi
    done
    echo "      완료!"
else
    echo "      에이전트 없음"
fi

# Commands 안내 (프로젝트별)
echo ""
echo "[3/4] Commands 안내... (프로젝트별 설치 필요)"
if [ -d "$SCRIPT_DIR/commands" ]; then
    echo "      Commands는 프로젝트별로 설치해야 합니다."
    echo "      프로젝트 폴더에서 다음 명령 실행:"
    echo ""
    echo "      mkdir -p .claude/commands"
    echo "      cp $SCRIPT_DIR/commands/*.md .claude/commands/"
    echo ""
    echo "      포함된 Commands:"
    for cmd_file in "$SCRIPT_DIR/commands"/*.md; do
        if [ -f "$cmd_file" ]; then
            echo "      - $(basename "$cmd_file")"
        fi
    done
else
    echo "      명령어 없음"
fi

# Hooks 안내 (프로젝트별)
echo ""
echo "[4/4] Hooks 안내... (프로젝트별 설치 필요)"
if [ -d "$SCRIPT_DIR/hooks" ]; then
    echo "      Hooks는 프로젝트별로 설치해야 합니다."
    echo "      프로젝트 폴더에서 다음 명령 실행:"
    echo ""
    echo "      mkdir -p .claude/hooks"
    echo "      cp $SCRIPT_DIR/hooks/*.sh .claude/hooks/"
    echo ""
    echo "      그리고 hooks/settings.example.json을 참고하여"
    echo "      .claude/settings.json에 hooks 설정을 추가하세요."
else
    echo "      훅 없음"
fi

echo ""
echo "============================================"
echo "  설치 완료!"
echo "============================================"
echo ""
echo "  글로벌 설치 완료:"
echo "  - Skills: $CLAUDE_DIR/skills/"
echo "  - Agents: $CLAUDE_DIR/agents/"
echo ""
echo "  프로젝트별 설치 필요:"
echo "  - Commands: .claude/commands/"
echo "  - Hooks: .claude/hooks/ + settings.json"
echo ""
echo "  Claude Code를 재시작하면 적용됩니다."
echo ""
