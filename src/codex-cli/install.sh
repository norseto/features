#!/usr/bin/env bash
# Copyright (c) 2024 Norihiro Seto. All rights reserved.

set -e

if [ -n "${REMOTE_USER:-}" ]; then
    _REMOTE_USER="${REMOTE_USER}"
    if [ "${REMOTE_USER}" == "root" ]; then
        _REMOTE_USER_HOME="/root"
    else
        _REMOTE_USER_HOME="/home/${REMOTE_USER}"
    fi
fi

VERSION="${VERSION:-latest}"
BUN_INSTALL="${_REMOTE_USER_HOME}/.bun"
export PATH="${BUN_INSTALL}/bin:$PATH"

sudo -iu $_REMOTE_USER <<EOF
    curl -fsSL https://bun.sh/install | bash
EOF

# Install Codex CLI
echo "Installing Codex CLI (version: ${VERSION})..."
ln -f -s "${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/node"
ln -f -s "${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/npm"
ln -f -s "${BUN_INSTALL}/bin/bunx" "${BUN_INSTALL}/bin/npx"

chown -h --reference="${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/node"
chown -h --reference="${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/npm"
chown -h --reference="${BUN_INSTALL}/bin/bunx" "${BUN_INSTALL}/bin/npx"

echo "🐰 Using Bun $(sudo -iu $_REMOTE_USER ${BUN_INSTALL}/bin/bun --version) for installation"

# Install the specified version of Codex CLI using Bun
if [ "$VERSION" = "latest" ]; then
    sudo -iu $_REMOTE_USER ${BUN_INSTALL}/bin/bun install -g @openai/codex
else
    sudo -iu $_REMOTE_USER ${BUN_INSTALL}/bin/bun install -g @openai/codex@"$VERSION"
fi

# Verify installation
if sudo -iu $_REMOTE_USER command -v ${BUN_INSTALL}/bin/codex &> /dev/null; then
    echo "✅ Codex CLI installed successfully!"
else
    echo "❌ Failed to install Codex CLI"
    exit 1
fi
