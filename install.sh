#!/bin/bash

# install.sh - Setup script for development container
# This script sets up the development container environment

set -e

echo "Starting setup-devcontainer installation..."

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Main installation function
main() {
    log "Setting up development container..."
    apt-get update

    log "installing claude code..."
    curl -fsSL https://claude.ai/install.sh | bash

    log "installing volta..."
    curl https://get.volta.sh | bash

    # For example:
    # - Install dependencies
    # - Configure environment
    # - Set up tools

    log "Development container setup completed successfully!"

    apt-get install -y zsh
    log "$(zsh --version) was installed!"

    # shellcheck disable=SC2016
    echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$HOME/.zshrc"
    log "Added $HOME/.local/bin to PATH in .zshrc"
}

# Run main function
main "$@"
