#!/bin/bash
# .claude/hooks/format-typescript.sh
# TypeScript/JavaScript 파일 자동 포맷팅

FILE_PATH="$1"

# TS/JS 파일인지 확인
if [[ "$FILE_PATH" != *.ts && "$FILE_PATH" != *.tsx && "$FILE_PATH" != *.js && "$FILE_PATH" != *.jsx ]]; then
    exit 0
fi

# node_modules 제외
if [[ "$FILE_PATH" == *"node_modules"* ]]; then
    exit 0
fi

echo "📝 Formatting TypeScript file: $FILE_PATH"

# Prettier 실행
if command -v npx &> /dev/null; then
    npx prettier --write "$FILE_PATH" 2>/dev/null

    # ESLint fix
    npx eslint --fix "$FILE_PATH" 2>/dev/null

    echo "✅ Formatted: $FILE_PATH"
else
    echo "⚠️  npx not found. Skipping formatting."
fi

exit 0
