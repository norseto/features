#!/bin/bash
# Copyright (c) 2024 Norihiro Seto. All rights reserved.

set -e

# Set BUN_INSTALL if not already set
BUN_INSTALL=${_REMOTE_USER_HOME}/.bun
export PATH="$BUN_INSTALL/bin:$PATH"

echo "BUN_INSTALL=${BUN_INSTALL}"
echo "PATH=${PATH}"
echo "ls -l ${BUN_INSTALL}/bin"
exit 0

VERSION="${VERSION:-latest}"

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
else
    echo "❌ Failed to install Codex CLI"
    exit 1
fi
