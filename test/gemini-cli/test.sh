#!/bin/bash
# Test script for Gemini CLI feature

set -e

echo "🏗️ Starting Gemini CLI installation test..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js is not installed"
    exit 1
fi
echo "✅ Node.js $(node --version) is installed"

# Check if gemini command is available
if ! command -v gemini &> /dev/null; then
    echo "❌ Error: gemini command not found in PATH"
    echo "Current PATH: $PATH"
    exit 1
fi
echo "✅ Gemini CLI is installed"

# Test gemini version
VERSION_OUTPUT=$(gemini --version 2>&1 || true)
if [[ -z "$VERSION_OUTPUT" ]]; then
    echo "❌ Error: gemini --version did not return output"
    exit 1
fi
echo "✅ Gemini CLI version: $VERSION_OUTPUT"

echo "🎉 Gemini CLI installation test completed successfully!"
