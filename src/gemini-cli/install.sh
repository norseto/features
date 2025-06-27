#!/usr/bin/env bash
# Copyright (c) 2025 Norihiro Seto. All rights reserved.

set -e
export DEBIAN_FRONTEND=noninteractive

if [ -n "${REMOTE_USER:-}" ]; then
    _REMOTE_USER="${REMOTE_USER}"
    if [ "${REMOTE_USER}" == "root" ]; then
        _REMOTE_USER_HOME="/root"
    else
        _REMOTE_USER_HOME="/home/${REMOTE_USER}"
    fi
fi

# Check if OS is Debian-based
if [ ! -f /etc/debian_version ]; then
    echo "Error: This feature is only supported on Debian-based distributions."
    exit 1
fi

VERSION="${VERSION:-latest}"

if [ "${INSTALL_NODE:-false}" != "false" ]; then
    sudo -iu $_REMOTE_USER bash -c 'curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -'
    sudo apt-get update && sudo apt-get install -y nodejs
fi

# Install Google Gemini CLI
echo "Installing Google Gemini CLI (version: ${VERSION})..."
if [ "$VERSION" = "latest" ]; then
    sudo -iu $_REMOTE_USER npm install -g @google/gemini-cli
else
    sudo -iu $_REMOTE_USER npm install -g @google/gemini-cli@"$VERSION"
fi

# Verify installation
if sudo -iu $_REMOTE_USER command -v gemini &> /dev/null; then
    echo "✅ Google Gemini CLI installed successfully!"
else
    echo "❌ Installation failed."
    exit 1
fi
