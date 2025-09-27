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

    log "Installing essential packages..."
    apt-get update
    apt-get install -y curl git zsh less

    log "Changing default shell to zsh..."
    chsh -s /bin/zsh

    log "Fetching setup-devcontainer repo..."
    SETUP_REPO_ROOT="$(pwd)/.setup-devcontainer"
    if [ ! -d "$SETUP_REPO_ROOT" ]; then
        git clone https://github.com/buko106/setup-devcontainer.git "$SETUP_REPO_ROOT"
    fi
    git -C "$SETUP_REPO_ROOT" fetch
    git -C "$SETUP_REPO_ROOT" checkout origin/HEAD

    log "Setting up static links to dotfiles..."
    ln -nfs "$SETUP_REPO_ROOT/dotfiles/.zshrc" ~/.zshrc
    ln -nfs "$SETUP_REPO_ROOT/dotfiles/.p10k.zsh" ~/.p10k.zsh

    log "Setting global gitignore"
    ln -nfs "$SETUP_REPO_ROOT/dotfiles/.gitignore_global" ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
}

# Run main function
main "$@"
