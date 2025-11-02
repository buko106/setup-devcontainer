#!/bin/bash

# install.sh - Setup script for development container
# This script sets up the development container environment

set -e

echo "Starting setup-devcontainer installation..."

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

setup_claude_code() {
    log "Setting up claude-code..."
    curl -fsSL https://claude.ai/install.sh | bash
    claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$(pwd)"

    log "Configuring claude-code settings..."
    mkdir -p ~/.claude
    if [ ! -f ~/.claude/settings.json ]; then
        echo '{}' >~/.claude/settings.json
    fi

    jq '.statusLine = {"type": "command", "command": "npx ccusage@latest statusline"}' ~/.claude/settings.json >~/.claude/settings.json.tmp && mv ~/.claude/settings.json.tmp ~/.claude/settings.json
}

setup_task() {
    log "Setting up task..."
    curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.deb.sh' | bash
    apt-get install -y task
}

# Main installation function
main() {
    log "Setting up development container..."

    if [ ! -f /.dockerenv ]; then
        log "This script is intended to be run inside a Docker container."
        exit 1
    elif [ ! -f /etc/debian_version ]; then
        log "This script is intended for Debian-based systems."
        exit 1
    fi

    log "Installing essential packages..."
    apt-get update
    apt-get install -y curl git zsh less direnv jq

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
    ln -nfs "$SETUP_REPO_ROOT/.zshrc" ~/.zshrc
    ln -nfs "$SETUP_REPO_ROOT/dotfiles" ~/dotfiles

    log "Setting git settings..."
    ln -nfs "$SETUP_REPO_ROOT/.gitignore_global" ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
    git config --global core.quotepath false
    git config --global core.pager "LESSCHARSET=utf-8 less"
    git config --global push.autoSetupRemote true

    setup_claude_code
    setup_task
}

# Run main function
main "$@"
