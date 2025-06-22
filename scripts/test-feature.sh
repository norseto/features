#!/bin/bash
# Test runner for devcontainer features
# This script is designed to run inside a devcontainer

set -e

FEATURE_DIR="$1"
FEATURE_NAME=$(basename "${FEATURE_DIR}")

if [ -z "${FEATURE_DIR}" ] || [ ! -d "${FEATURE_DIR}" ]; then
    echo "Usage: $0 <path-to-feature>"
    echo "Example: $0 src/codex-cli"
    exit 1
fi

echo "🔍 Testing feature: ${FEATURE_NAME}"

# Check if running in a container
if [ ! -f /.dockerenv ]; then
    echo "⚠️  This script must be run inside a devcontainer."
    echo "   Please run 'devcontainer up' first, then run this script from inside the container."
    exit 1
fi

# Check for required dependencies
if ! command -v bun &> /dev/null; then
    echo "❌ Error: Bun is not installed. Please ensure the Bun feature is installed."
    exit 1
fi

echo "✅ Dependencies verified"

# Run the install script
echo "🚀 Running installation..."
if [ -f "${FEATURE_DIR}/install.sh" ]; then
    chmod +x "${FEATURE_DIR}/install.sh"
    (cd "${FEATURE_DIR}" && ./install.sh)
    if [ $? -ne 0 ]; then
        echo "❌ Installation failed"
        exit 1
    fi
    echo "✅ Installation successful"
else
    echo "❌ install.sh not found in ${FEATURE_DIR}"
    exit 1
fi

# Run tests if they exist
TEST_SCRIPT="test/${FEATURE_NAME}/test.sh"
if [ -f "${TEST_SCRIPT}" ]; then
    echo "🧪 Running tests..."
    chmod +x "${TEST_SCRIPT}"
    # Pass any additional arguments to the test script
    (cd "$(dirname "${TEST_SCRIPT}")" && ./test.sh "$@")
    if [ $? -ne 0 ]; then
        echo "❌ Tests failed"
        exit 1
    fi
    echo "✅ All tests passed"
else
    echo "⚠️  No tests found at ${TEST_SCRIPT}"
fi

echo "✨ Feature test completed successfully"
