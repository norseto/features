#!/bin/bash
# Test script for Claude Code CLI feature

set -e

echo "🏗️ Starting Claude Code CLI installation test..."

# Check if Bun is installed
if ! command -v bun &> /dev/null; then
    echo "❌ Error: Bun is not installed"
    exit 1
fi
echo "✅ Bun $(bun --version) is installed"

# Check if claude command is available
if ! command -v claude &> /dev/null; then
    echo "❌ Error: claude command not found in PATH"
    echo "Current PATH: $PATH"
    echo "Bun global bin: $(bun get global dir)/bin"
    exit 1
fi
echo "✅ Claude Code CLI is installed"

# Test claude version
VERSION_OUTPUT=$(claude --version 2>&1 || true)
if [[ -z "$VERSION_OUTPUT" ]]; then
    echo "❌ Error: claude --version did not return output"
    exit 1
fi
echo "✅ Claude Code CLI version: $VERSION_OUTPUT"

echo "🎉 Claude Code CLI installation test completed successfully!"
