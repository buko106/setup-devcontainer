# setup-devcontainer

A simple setup script for development containers.

## Quick Installation

You can run the installation script directly using curl:

```bash
curl -fsSL https://raw.githubusercontent.com/buko106/setup-devcontainer/master/install.sh | bash
```

## Development Tools

### Shellcheck Installation

Shellcheck is a static analysis tool for shell scripts. Install it using one of the following methods:

#### On Ubuntu/Debian:
```bash
sudo apt install shellcheck
```

#### On macOS:
```bash
brew install shellcheck
```

#### Using snap:
```bash
sudo snap install shellcheck
```

#### From GitHub releases:
```bash
# Download the latest release for your platform from:
# https://github.com/koalaman/shellcheck/releases
```

### shfmt Installation

shfmt is a shell formatter. Install it using one of the following methods:

#### Using go install:
```bash
go install mvdan.cc/sh/v3/cmd/shfmt@latest
```

#### On macOS:
```bash
brew install shfmt
```

#### Using snap:
```bash
sudo snap install shfmt
```

#### From GitHub releases:
```bash
# Download the latest release for your platform from:
# https://github.com/mvdan/sh/releases
```

## Running Shell Check

To lint the shell scripts in this repository:

```bash
# Check the install.sh script
shellcheck install.sh

# Check all shell scripts recursively
find . -name "*.sh" -exec shellcheck {} \;

# Format shell scripts with shfmt
shfmt -w -i 4 install.sh
```