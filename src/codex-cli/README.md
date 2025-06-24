# Codex CLI Feature

## Description

This feature installs the OpenAI Codex CLI tool using [Bun](https://bun.sh/), a fast JavaScript runtime and package manager.

> **Prerequisite**: This feature requires the [Bun feature](https://github.com/michidk/devcontainers-features/tree/main/src/bun) to be installed first.

## Options

| Option | Required | Default | Description |
|--------|----------|---------|-------------|
| `version` | No | `latest` | Version of Codex CLI to install |
| `install-bun` | No | false | Boolean option to control whether Bun is installed. |
| `remote-user` | No | "" | Remote user name. [DevPod workaround] |

* DevPod workaround: [DevPod](https://github.com/microsoft/devpod) does not support remoteUser option in feature(always vscode user). To work around this, you can use the `remote-user` option to specify the remote user name(eg. root).
* DevPod workaround: [DevPod](https://github.com/microsoft/devpod) does not support [dependency option in feature](https://github.com/loft-sh/devpod/issues/1073). To work around this, you can set true `install-bun` option to control whether Bun is installed.

## Usage Example

Add to your `devcontainer.json`:

```json
"features": {
    "ghcr.io/norseto/features/codex-cli:1": {
        "version": "latest"
    }
}
```

## Requirements

- Internet connection (for downloading packages)
- Node.js and npm (will be installed automatically if not present)

## Installation Details

- Installs Node.js using nvm (Node Version Manager) if not already present
- Installs the specified version of `@openai/codex` globally using npm
- Adds npm's global bin directory to the system PATH

## Post-Installation

After installation, you'll need to set your OpenAI API key:

```bash
export OPENAI_API_KEY='your-api-key-here'
```

## License

See https://github.com/norseto/features/blob/main/LICENSE
