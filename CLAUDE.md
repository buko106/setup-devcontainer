# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a simple shell script repository that provides a setup script for development containers. The main component is `install.sh`, which automates the installation of Claude Code and other development tools in container environments.

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
# Run the install script locally
./install.sh

# Run via curl (production usage)
curl -fsSL https://raw.githubusercontent.com/buko106/setup-devcontainer/main/install.sh | bash
```

## Code Architecture

### Core Components
- `install.sh`: Main installation script that sets up development container environment
  - Uses `set -e` for error handling
  - Includes logging function for timestamped output
  - Currently installs Claude Code via curl
  - Designed to be extensible for additional development tools

### Development Tools
The project uses shellcheck for static analysis and shfmt for formatting shell scripts. These tools ensure code quality and consistent formatting across the repository.

## Repository Structure
- Single shell script approach - all setup logic is contained in `install.sh`
- README.md provides installation instructions for development tools
- IntelliJ IDEA project configuration in `.idea/` directory