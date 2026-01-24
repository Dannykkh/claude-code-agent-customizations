#!/bin/bash
# .claude/hooks/format-java.sh
# Java 파일 자동 포맷팅

FILE_PATH="$1"

# Java 파일인지 확인
if [[ "$FILE_PATH" != *.java ]]; then
    exit 0
fi

# google-java-format 존재 확인
if command -v google-java-format &> /dev/null; then
    echo "📝 Formatting Java file: $FILE_PATH"
    google-java-format -i "$FILE_PATH"
    echo "✅ Formatted: $FILE_PATH"
elif command -v ./gradlew &> /dev/null; then
    # Gradle spotless 사용
    echo "📝 Running Gradle spotlessApply..."
    ./gradlew spotlessApply -q
else
    echo "⚠️  No Java formatter found. Skipping formatting."
fi

exit 0
