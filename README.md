# setup-devcontainer

An automated setup script for development containers that configures essential tools, dotfiles, and development environment.

## Features

- 🐚 Installs and configures **zsh** as default shell
- 📝 Sets up **dotfiles** (`.zshrc`, `.gitignore_global`) via symbolic links
- 🔧 Installs development tools:
  - **Claude Code** (Anthropic's CLI tool)
  - **Task** (taskfile.dev - modern task runner)
  - **direnv** (environment variable management)
- ⚙️ Configures **git** global settings
- 📦 Essential packages: curl, git, zsh, less, direnv

## Prerequisites

- ⚠️ **Must run inside a Docker container** (checks for `/.dockerenv`)
- ⚠️ **Debian-based systems only** (checks for `/etc/debian_version`)

## Installation

Run the installation script directly using curl:

```bash
curl -fsSL https://raw.githubusercontent.com/buko106/setup-devcontainer/main/install.sh | bash
```

## What It Does

1. Verifies Docker container and Debian environment
2. Installs essential packages via apt-get
3. Changes default shell to zsh
4. Clones/updates this repository into `.setup-devcontainer/`
5. Creates symbolic links for dotfiles
6. Configures git global settings
7. Installs Claude Code via npm
8. Installs Task from Cloudsmith repository

## Development

### Linting and Formatting

```bash
# Lint the install script
shellcheck install.sh

# Format with shfmt (4-space indentation)
shfmt -w -i 4 install.sh
```

### Development Tools Installation

#### Shellcheck (static analysis for shell scripts)

```bash
# Ubuntu/Debian
sudo apt install shellcheck

# macOS
brew install shellcheck
```

#### shfmt (shell script formatter)

```bash
# Using go
go install mvdan.cc/sh/v3/cmd/shfmt@latest

# macOS
brew install shfmt
```