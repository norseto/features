# DevContainer Features

This repository contains custom DevContainer Features for development environments.

> **Note**: This project uses [Bun](https://bun.sh/) as the JavaScript runtime and package manager.

## Available Features

### Codex CLI

Installs the OpenAI Codex CLI tool.

```json
"features": {
    "ghcr.io/norseto/features/codex-cli:1": {
        "version": "latest"
    }
}
```

See [src/codex-cli/README.md](src/codex-cli/README.md) for more details.

## Development Guide

### Adding a New Feature

1. Create a new directory under `src/` for your feature.
2. Create the following files:
   - `devcontainer-feature.json`: Feature metadata
   - `install.sh`: Installation script
   - `README.md`: Feature documentation
3. Add corresponding tests in the `test/` directory.

### Running Tests

```bash
# Run tests for a specific feature
./scripts/test-feature.sh src/<feature-name>
```

## License

See https://github.com/norseto/features/blob/main/LICENSE
