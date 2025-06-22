# Makefile for local build and push of DevContainer feature
# Requires: devcontainer CLI, docker, jq

# Feature name (matches directory under src/)
FEATURE ?= codex-cli
# Image repository prefix
IMAGE_REPO ?= ghcr.io/norseto/features/$(FEATURE)

# Extract version from devcontainer-feature.json
VERSION ?= $(shell jq -r .version src/$(FEATURE)/devcontainer-feature.json)

# Tags
BUILD_TAG = $(IMAGE_REPO):$(VERSION)
LATEST_TAG = $(IMAGE_REPO):latest

.PHONY: build push all login

# Build the DevContainer feature package locally
build:
	devcontainer features package ./src/$(FEATURE) --output-folder ./output

# Publish feature to GHCR
publish:
	devcontainer features publish ./src/$(FEATURE) --namespace norseto/features --target $(BUILD_TAG)

# Build and push in one step
all: build publish

# Alias for backward compatibility
push: all

# Login to GHCR
login:
	echo $(GITHUB_TOKEN) | docker login ghcr.io -u $(USERNAME) --password-stdin