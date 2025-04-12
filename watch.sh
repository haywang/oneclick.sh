#!/bin/bash

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "Installing fswatch..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install fswatch
    elif command -v apt-get &> /dev/null; then
        # Debian/Ubuntu
        sudo apt-get update && sudo apt-get install -y fswatch
    elif command -v dnf &> /dev/null; then
        # Fedora
        sudo dnf install -y fswatch
    elif command -v pacman &> /dev/null; then
        # Arch Linux
        sudo pacman -S fswatch
    else
        echo "Unable to install fswatch. Please install it manually before running this script."
        exit 1
    fi
fi

# Ensure build.sh is executable
chmod +x build.sh

echo "Starting file watch..."
echo "Watching directories and files: src/ build.sh"
echo "Press Ctrl+C to stop watching"

# Watch for changes in src directory and build.sh file
fswatch -o src/ build.sh | while read f; do
    echo "File change detected: $f"
    echo "Rebuilding..."
    ./build.sh
    echo "Build complete!"
    echo "Continuing to watch for changes..."
done