#!/usr/bin/env bash
# Copyright (c) 2025 Norihiro Seto. All rights reserved.

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

# Check if OS is Debian-based
if [ ! -f /etc/debian_version ]; then
    echo "Error: This feature is only supported on Debian-based distributions."
    exit 1
fi

if [ "${INSTALL_BUN:-false}" != "false" ]; then
    sudo -iu $_REMOTE_USER <<EOF
    curl -fsSL https://bun.sh/install | bash
EOF
fi

# Install Google Gemini CLI
ln -f -s "${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/node"
ln -f -s "${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/npm"
ln -f -s "${BUN_INSTALL}/bin/bunx" "${BUN_INSTALL}/bin/npx"

chown -h --reference="${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/node"
chown -h --reference="${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/npm"
chown -h --reference="${BUN_INSTALL}/bin/bunx" "${BUN_INSTALL}/bin/npx"

echo "Installing Google Gemini CLI (version: ${VERSION})..."
if [ "$VERSION" = "latest" ]; then
    sudo -iu $_REMOTE_USER ${BUN_INSTALL}/bin/bun install -g @google/gemini-cli
else
    sudo -iu $_REMOTE_USER ${BUN_INSTALL}/bin/bun install -g @google/gemini-cli@"$VERSION"
fi

# Verify installation
if sudo -iu $_REMOTE_USER command -v ${BUN_INSTALL}/bin/gemini &> /dev/null; then
    echo "✅ Google Gemini CLI installed successfully!"
else
    echo "❌ Installation failed."
    exit 1
fi
