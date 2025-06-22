#!/bin/bash
# Test script for Codex CLI feature

set -e

echo "🏗️ Starting Codex CLI installation test..."

# Check if Bun is installed
if ! command -v bun &> /dev/null; then
    echo "❌ Error: Bun is not installed"
    exit 1
fi
echo "✅ Bun $(bun --version) is installed"

# Check if codex command is available
if ! command -v codex &> /dev/null; then
    echo "❌ Error: codex command not found in PATH"
    echo "Current PATH: $PATH"
    echo "Bun global bin: $(bun get global dir)/bin"
    exit 1
fi
echo "✅ Codex CLI is installed"

# Test codex version
VERSION_OUTPUT=$(codex --version 2>&1 || true)
if [ -z "$VERSION_OUTPUT" ]; then
    echo "❌ Error: 'codex --version' returned empty output"
    exit 1
fi

echo "✅ Codex CLI version: $VERSION_OUTPUT"

# If specific version was requested, verify it
if [ "$VERSION" != "latest" ] && [ "$VERSION" != "" ]; then
    if [[ ! "$VERSION_OUTPUT" =~ $VERSION ]]; then
        echo "❌ Error: Incorrect version. Expected to find '$VERSION' in '$VERSION_OUTPUT'"
        exit 1
    fi
    echo "✅ Correct version ($VERSION) is installed"
else
    echo "ℹ️  Installed version: $VERSION_OUTPUT"
fi

echo -e "\n✅ All tests passed!"

echo -e "\nNext steps:\n"
echo "1. Set your OpenAI API key:"
echo "   export OPENAI_API_KEY='your-api-key-here'"
echo "2. Try running: codex --help"

exit 0
