#!/usr/bin/env bash

set -e

bun install -g @devcontainers/cli@latest
BUN_INSTALL="${HOME}/.bun"
ln -sf "${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/node"
ln -sf "${BUN_INSTALL}/bin/bun" "${BUN_INSTALL}/bin/npm"
ln -sf "${BUN_INSTALL}/bin/bunx" "${BUN_INSTALL}/bin/npx"
