#!/bin/bash
# Copyright (c) 2024 Norihiro Seto. All rights reserved.

set -e

# Clean up
cleanup() {
    exit_code=$?
    # Add any cleanup code here
    exit $exit_code
}
trap cleanup EXIT

# Default values
VERSION="${VERSION:-latest}"

# Check if Bun is installed
if ! command -v bun &> /dev/null; then
    echo "❌ Error: Bun is required but not found. Please install Bun first."
    echo "   Visit https://bun.sh/docs/installation for installation instructions."
    exit 1
fi

echo "🐰 Using Bun $(bun --version) for installation"

# Install Codex CLI
echo "Installing Codex CLI (version: ${VERSION})..."
ln -f -s "${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/node"
ln -f -s "${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/npm"
ln -f -s "${BUN_INSTALL}/bin/bunx" "${BUN_INSTALL}/bin/npx"

# Install the specified version of Codex CLI using Bun
if [ "$VERSION" = "latest" ]; then
    npm install -g @openai/codex
else
    npm install -g @openai/codex@"$VERSION"
fi

# Verify installation
if command -v codex &> /dev/null; then
    echo "✅ Codex CLI installed successfully!"
    codex --version
    
    # Provide setup instructions
    echo -e "\nTo get started with Codex CLI:"
    echo "1. Set up your OpenAI API key:"
    echo "   export OPENAI_API_KEY='your-api-key-here'"
    echo "2. Run 'codex --help' to see available commands"
else
    echo "❌ Failed to install Codex CLI"
    echo "   Check if the package is in Bun's global bin directory"
    echo "   Bun global bin: $(bun get global dir)/bin"
    exit 1
fi
