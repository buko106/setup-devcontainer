# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A setup script repository for development containers that automates installation of development tools and dotfiles configuration. **Must be run inside a Docker container on Debian-based systems.**

## Common Development Commands

### Shell Script Linting and Formatting
```bash
# Lint the main install script
shellcheck install.sh

# Lint all shell scripts in the repository
find . -name "*.sh" -exec shellcheck {} \;

# Format shell scripts with shfmt (uses 4-space indentation)
shfmt -w -i 4 install.sh

# Format all shell scripts
find . -name "*.sh" -exec shfmt -w -i 4 {} \;
```

### Testing the Installation Script
```bash
# Run the install script locally (must be in Docker container on Debian)
./install.sh

# Run via curl (production usage)
curl -fsSL https://raw.githubusercontent.com/buko106/setup-devcontainer/main/install.sh | bash
```

## Code Architecture

### Core Components
- `install.sh`: Main installation script that sets up development container environment
  - **Prerequisites**: Must run inside Docker container (checks `/.dockerenv`) on Debian-based systems (checks `/etc/debian_version`)
  - Uses `set -e` for error handling
  - Includes `log()` function for timestamped output (install.sh:11-13)
  - Installs essential packages: curl, git, zsh, less, direnv via apt-get
  - Sets zsh as default shell
  - Clones/updates this repository into `.setup-devcontainer/` subdirectory
  - Creates symbolic links for dotfiles: `.zshrc`, `dotfiles/` directory, `.gitignore_global`
  - Configures git global settings (core.excludesfile, core.quotepath, core.pager, push.autoSetupRemote)
  - Installs Claude Code via npm global install
  - Installs Task (taskfile.dev) via Cloudsmith repository

### Development Tools
The project uses shellcheck for static analysis and shfmt for formatting shell scripts. These tools ensure code quality and consistent formatting across the repository (4-space indentation).