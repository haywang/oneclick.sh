#!/bin/bash

# This script updates the version in build.sh and creates a new git tag

# Ensure we're in the root project directory
cd "$(dirname "$0")"

# Current version from build.sh
CURRENT_VERSION=$(grep "VERSION=" build.sh | head -n 1 | cut -d '"' -f 2)
echo "Current version: $CURRENT_VERSION"

# Ask for new version or use increment
read -p "Enter new version (leave empty to increment patch version): " NEW_VERSION

if [ -z "$NEW_VERSION" ]; then
    # Parse current version
    MAJOR=$(echo $CURRENT_VERSION | cut -d. -f1)
    MINOR=$(echo $CURRENT_VERSION | cut -d. -f2)
    PATCH=$(echo $CURRENT_VERSION | cut -d. -f3)

    # Increment patch version
    PATCH=$((PATCH + 1))
    NEW_VERSION="$MAJOR.$MINOR.$PATCH"
    echo "Auto-incrementing to version: $NEW_VERSION"
fi

# Update version in build.sh - OS-specific approach
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS version of sed requires a backup extension
    sed -i '' "s/VERSION=\"[^\"]*\"/VERSION=\"$NEW_VERSION\"/" build.sh
else
    # Linux version of sed
    sed -i "s/VERSION=\"[^\"]*\"/VERSION=\"$NEW_VERSION\"/" build.sh
fi

# Verify the change was made
NEW_VERSION_CHECK=$(grep "VERSION=" build.sh | head -n 1 | cut -d '"' -f 2)
if [ "$NEW_VERSION" != "$NEW_VERSION_CHECK" ]; then
    echo "ERROR: Version update failed. Current version in build.sh is still: $NEW_VERSION_CHECK"
    exit 1
fi

echo "Version updated to $NEW_VERSION in build.sh"

# Commit the change
git add build.sh
git commit -m "Bump version to $NEW_VERSION"

# Create a tag
git tag -a "v$NEW_VERSION" -m "Version $NEW_VERSION"

echo "Changes committed and tag v$NEW_VERSION created locally."
echo "To push the new version, run:"
echo "  git push && git push --tags"