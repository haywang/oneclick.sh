#!/bin/bash

# Set installation directory
INSTALL_DIR="$HOME/.oneclick"
BIN_DIR="$HOME/bin"

# Define repository owner and name (hardcoded as fallback)
REPO_OWNER="haywang"
REPO_NAME="oneclick.sh"

# Try to get repository information from git if available
if command -v git &> /dev/null && git rev-parse --is-inside-work-tree &> /dev/null; then
  REMOTE_URL=$(git config --get remote.origin.url)
  if [ -n "$REMOTE_URL" ]; then
    # Extract owner and repo name from the URL
    if [[ "$REMOTE_URL" == *"github.com"* ]]; then
      if [[ "$REMOTE_URL" == *":"* ]]; then
        # SSH URL format (git@github.com:owner/repo.git)
        REPO_FULL_NAME=$(echo "$REMOTE_URL" | sed -E 's/.*:(.*)\.git/\1/')
      else
        # HTTPS URL format (https://github.com/owner/repo.git)
        REPO_FULL_NAME=$(echo "$REMOTE_URL" | sed -E 's/.*github\.com\/(.*)\.git/\1/')
      fi

      if [[ "$REPO_FULL_NAME" == *"/"* ]]; then
        REPO_OWNER=$(echo "$REPO_FULL_NAME" | cut -d'/' -f1)
        REPO_NAME=$(echo "$REPO_FULL_NAME" | cut -d'/' -f2)
      fi
    fi
  fi
fi

echo "Installing from repository: $REPO_OWNER/$REPO_NAME"

# Get the latest release version
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest" | grep "tag_name" | cut -d '"' -f 4)

# If there's no release yet, use default URL or exit
if [ -z "$LATEST_RELEASE" ]; then
  echo "No releases found. Using the latest code from the main branch."
  DOWNLOAD_URL="https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/main.tar.gz"
  IS_RELEASE=false
else
  DOWNLOAD_URL="https://github.com/$REPO_OWNER/$REPO_NAME/releases/download/$LATEST_RELEASE/oneclick.tar.gz"
  IS_RELEASE=true
  echo "Found release: $LATEST_RELEASE"
fi

# Create temporary directory
TMP_DIR=$(mktemp -d)
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

# Download and extract
echo "Downloading oneclick.sh..."
curl -sL "$DOWNLOAD_URL" -o "$TMP_DIR/oneclick.tar.gz"

if [ $? -ne 0 ]; then
  echo "Failed to download. Please check your internet connection and try again."
  exit 1
fi

# Create installation directory
mkdir -p "$INSTALL_DIR"

# Extract files
echo "Extracting files..."
if [ "$IS_RELEASE" = true ]; then
  # For release packages
  tar -xzf "$TMP_DIR/oneclick.tar.gz" -C "$INSTALL_DIR"
else
  # For source code archive
  mkdir -p "$TMP_DIR/src"
  tar -xzf "$TMP_DIR/oneclick.tar.gz" -C "$TMP_DIR/src" --strip-components=1

  # Build from source
  echo "Building from source..."
  cd "$TMP_DIR/src"
  ./build.sh

  # Copy the built files
  cp -r dist/* "$INSTALL_DIR/"
fi

# Make the script executable
chmod +x "$INSTALL_DIR/oneclick.sh"

# Create symbolic link
mkdir -p "$BIN_DIR"
ln -sf "$INSTALL_DIR/oneclick.sh" "$BIN_DIR/oneclick"

# Add to PATH if needed
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"

  # If zsh exists, update its config too
  if [ -f "$HOME/.zshrc" ]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.zshrc"
  fi

  echo "Added $HOME/bin to PATH. Please restart your terminal or run 'source ~/.bashrc'"
fi

echo "oneclick.sh has been installed successfully!"
echo "You can now run it by typing 'oneclick' in your terminal."