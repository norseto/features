# Gemini CLI Feature

## Description

This feature installs the Google Gemini CLI tool using [Bun](https://bun.sh/), a fast JavaScript runtime and package manager.

> **Prerequisite**: This feature requires the [Bun feature](https://github.com/michidk/devcontainers-features/tree/main/src/bun) to be installed first.

## Options

| Option       | Required | Default | Description |
|--------------|----------|---------|-------------|
| `version`    | No       | `latest` | Version of Gemini CLI to install |
| `install-bun` | No       | false    | Boolean option to control whether Bun is installed. |
| `remote-user` | No       | ""      | Remote user name. [DevPod workaround] |

* DevPod workaround: [DevPod](https://github.com/microsoft/devpod) does not support dependency options. Use `install-bun` to control Bun installation.

## Usage Example

Add to your `devcontainer.json`:

```json
"features": {
    "ghcr.io/norseto/features/gemini-cli:1": {
        "version": "latest"
    }
}
```

## Requirements

- Internet connection (for downloading packages)
- Debian-based distribution (checked automatically)

## Installation Details

- Installs Bun if `install-bun` is true
- Installs xdg-utils for better desktop integration
- Installs the specified version of `@google/generative-ai` globally using Bun
- Adds Bun's global bin directory to the system PATH

## Post-Installation

After installation, set your Google API key:

```bash
export GOOGLE_API_KEY='your-api-key-here'
```

Refer to the [Google Generative AI documentation](https://ai.google.dev/generative-ai/docs/cli) for usage details.

## Testing and Verification

After installation, you can verify the Generative AI CLI setup by running the provided test script:

1. Navigate to the test directory: `cd /workspaces/features/test/generative-ai-cli`
2. Run the test script: `./test.sh`

This script checks if Node.js and the Generative AI CLI are installed correctly and outputs the version for confirmation.

## License

See https://github.com/norseto/features/blob/main/LICENSE
