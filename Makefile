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

.PHONY: build push all

# Build the DevContainer feature image locally
build:
	devcontainer features build --workspace . --features src/$(FEATURE) --output $(BUILD_TAG)

# Push built image and latest tag to GHCR
push: build
	docker push $(BUILD_TAG)
	docker tag $(BUILD_TAG) $(LATEST_TAG)
	docker push $(LATEST_TAG)

# Build and push in one step
all: push
