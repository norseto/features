# DevContainer Features

This repository contains custom DevContainer Features for development environments.

> **Note**: This project uses [Bun](https://bun.sh/) as the JavaScript runtime and package manager.

## Available Features

### Codex CLI

Installs the OpenAI Codex CLI tool.

```json
"features": {
    "ghcr.io/norseto/features/codex-cli:0": {
        "version": "latest"
    }
}
```

See [src/codex-cli/README.md](src/codex-cli/README.md) for more details.

### Claude Code CLI

Installs the Anthropic Claude Code CLI tool.

```json
"features": {
    "ghcr.io/norseto/features/claude-code-cli:0": {
        "version": "latest"
    }
}
```

See [src/claude-code-cli/README.md](src/claude-code-cli/README.md) for more details.

### Gemini CLI

Installs the Google Gemini CLI tool.

```json
"features": {
    "ghcr.io/norseto/features/gemini-cli:0": {
        "version": "latest"
    }
}
```

See [src/gemini-cli/README.md](src/gemini-cli/README.md) for more details.

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
