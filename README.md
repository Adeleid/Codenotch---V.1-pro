<div align="center">

# Codenotch V.1 Pro

### Adeleid Edition

[![Pro CI](https://github.com/Adeleid/Codenotch---V.1-pro/actions/workflows/pro-ci.yml/badge.svg)](https://github.com/Adeleid/Codenotch---V.1-pro/actions/workflows/pro-ci.yml)
![Platform](https://img.shields.io/badge/platform-macOS%2015%2B-black)
![Swift](https://img.shields.io/badge/swift-5-orange)
![License](https://img.shields.io/badge/license-MIT-green)

**A macOS coding-assistant usage monitor maintained and branded by Adeleid.**

</div>

Codenotch V.1 Pro places a compact notch-style monitor on the edge of your Mac display and shows usage, activity and status for supported AI coding assistants.

## Adeleid V.1 Pro

This repository is the Adeleid-maintained derivative of the original Codenotch project.

- App display name: **Codenotch V.1 Pro**
- Bundle identifier: `com.adeleid.codenotchpro`
- Maintainer: **Adeleid**
- Update feed: Adeleid repository only
- Automatic updates: disabled until Adeleid publishes signed releases
- macOS CI: tested using macOS 26 / Xcode 26 SDK

The original upstream code remains credited under the MIT License. New branding, modifications, additions and documentation in this repository are maintained by Adeleid.

## Providers

Codenotch supports multiple local coding assistants and usage sources, including:

- Claude Code
- Cursor
- Codex
- Antigravity
- GLM
- Ollama Local
- Grok
- OpenCode
- Command Code
- GitHub Copilot

Provider credentials and local sessions remain owned by their respective tools. Codenotch reads supported local state and provider usage information; it does not replace the provider applications.

## Build from source

Requirements:

- macOS 15 or later
- Xcode with a macOS 26 SDK for code paths that compile Liquid Glass APIs
- Homebrew
- XcodeGen

```sh
brew install xcodegen
git clone https://github.com/Adeleid/Codenotch---V.1-pro.git
cd Codenotch---V.1-pro
make run
```

Run tests:

```sh
make test
```

CI runs the test suite without requiring a Developer ID certificate.

## Preview / unsigned DMG

The repository can produce an ad-hoc signed preview DMG for testing. Preview builds are not Apple-notarized and may require clearing quarantine after installation:

```sh
xattr -dr com.apple.quarantine /Applications/Codenotch.app
```

A public production release should be signed with Adeleid's own Apple Developer ID and notarized before distribution.

## Updates

The fork does **not** use the original maintainer's Sparkle feed. The configured feed belongs to this Adeleid repository, and automatic checks remain disabled until a signed Adeleid update chain is ready.

## Repository safety

The branch `baseline-original` preserves the imported baseline used before Adeleid branding changes. Production work is merged into `main` only after CI verification.

## License and attribution

MIT License. See [`LICENSE`](LICENSE).

Original Codenotch copyright © 2026 Vinz.

Copyright © 2026 Adeleid for original modifications, branding, additions and new work in this derivative.

See [`ADELEID_NOTICE.md`](ADELEID_NOTICE.md) for the derivative-work notice.
