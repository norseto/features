# Claude Code CLI Feature

## Description

This feature installs the Anthropic Claude Code CLI tool using [Bun](https://bun.sh/), a fast JavaScript runtime and package manager.

> **Prerequisite**: This feature requires the [Bun feature](https://github.com/michidk/devcontainers-features/tree/main/src/bun) to be installed first.

## Options

| Option   | Required | Default | Description                                      |
|----------|----------|---------|--------------------------------------------------|
| `version`| No       | `latest`| Version of Claude Code CLI to install            |
| `install-bun` | No | false | Boolean option to control whether Bun is installed. |
| `remote-user` | No | "" | Remote user name. |

* DevPod workaround: [DevPod](https://github.com/microsoft/devpod) does not support remoteUser option (always vscode user). To work around this, you can use the `remote-user` option to specify the remote user name(eg. root).
* DevPod workaround: [DevPod](https://github.com/microsoft/devpod) does not support [dependency option in feature](https://github.com/loft-sh/devpod/issues/1073). To work around this, you can set true `install-bun` option to control whether Bun is installed.

## Usage Example

Add to your `devcontainer.json`:

```json
"features": {
    "ghcr.io/norseto/features/claude-code-cli:1": {
        "version": "latest"
    }
}
```

## Requirements

- Internet connection (for downloading packages)
- Node.js and npm (will be installed automatically if not present)

## Installation Details

- Installs Node.js using nvm (Node Version Manager) if not already present
- Installs the specified version of `@anthropic-ai/claude-code` globally using bun
- Adds bun's global bin directory to the system PATH

## Post-Installation

After installation, you'll need to set your Anthropic API key:

```sh
export ANTHROPIC_API_KEY=your-api-key
```

Refer to the [Anthropic Claude Code documentation](https://docs.anthropic.com/) for usage details.
