# Update menu functions

# Check for updates
check_for_updates() {
    local REPO_OWNER="haywang"
    local REPO_NAME="oneclick.sh"
    local CURRENT_VERSION="$VERSION"

    show_info "Checking for updates..."

    # Check if curl is available
    if ! command -v curl &> /dev/null; then
        show_error "curl is not installed. Cannot check for updates."
        return 1
    fi

    # Get the latest release version from GitHub
    local LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest" | grep "tag_name" | cut -d '"' -f 4)

    # If no release found or error
    if [ -z "$LATEST_RELEASE" ]; then
        show_warning "Could not retrieve latest version. Please check your internet connection."
        return 1
    fi

    # Remove 'v' prefix if present
    LATEST_RELEASE="${LATEST_RELEASE#v}"

    show_success "Current version: $CURRENT_VERSION"
    show_success "Latest version: $LATEST_RELEASE"

    # Compare versions
    if [ "$CURRENT_VERSION" = "$LATEST_RELEASE" ]; then
        show_success "You are using the latest version."
        return 0  # No update needed
    else
        # Version comparison based on semver (assuming format like 1.0.0)
        local CURRENT_MAJOR=$(echo $CURRENT_VERSION | cut -d. -f1)
        local CURRENT_MINOR=$(echo $CURRENT_VERSION | cut -d. -f2)
        local CURRENT_PATCH=$(echo $CURRENT_VERSION | cut -d. -f3)

        local LATEST_MAJOR=$(echo $LATEST_RELEASE | cut -d. -f1)
        local LATEST_MINOR=$(echo $LATEST_RELEASE | cut -d. -f2)
        local LATEST_PATCH=$(echo $LATEST_RELEASE | cut -d. -f3)

        local UPDATE_AVAILABLE=false

        if [ "$LATEST_MAJOR" -gt "$CURRENT_MAJOR" ]; then
            UPDATE_AVAILABLE=true
        elif [ "$LATEST_MAJOR" -eq "$CURRENT_MAJOR" ] && [ "$LATEST_MINOR" -gt "$CURRENT_MINOR" ]; then
            UPDATE_AVAILABLE=true
        elif [ "$LATEST_MAJOR" -eq "$CURRENT_MAJOR" ] && [ "$LATEST_MINOR" -eq "$CURRENT_MINOR" ] && [ "$LATEST_PATCH" -gt "$CURRENT_PATCH" ]; then
            UPDATE_AVAILABLE=true
        fi

        if [ "$UPDATE_AVAILABLE" = true ]; then
            show_warning "A new version is available. Would you like to update? (y/n)"
            read -r UPDATE_CHOICE

            if [[ "$UPDATE_CHOICE" =~ ^[Yy]$ ]]; then
                perform_update "$REPO_OWNER" "$REPO_NAME" "$LATEST_RELEASE"
                return 2  # Update was performed
            else
                show_warning "Update cancelled. Continuing with current version."
                return 0  # No update performed
            fi
        else
            show_success "You are using the latest version."
            return 0  # No update needed
        fi
    fi
}

# Perform the update
perform_update() {
    local REPO_OWNER="$1"
    local REPO_NAME="$2"
    local LATEST_VERSION="$3"
    local DOWNLOAD_URL="https://github.com/$REPO_OWNER/$REPO_NAME/releases/download/v$LATEST_VERSION/oneclick.tar.gz"

    # Create temporary directory
    local TMP_DIR=$(mktemp -d)
    local SCRIPT_PATH="$(readlink -f "$0")"
    local SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

    show_info "Downloading latest version..."

    # Download the latest release
    if ! curl -sL "$DOWNLOAD_URL" -o "$TMP_DIR/oneclick.tar.gz"; then
        show_error "Failed to download update. Please try again later."
        rm -rf "$TMP_DIR"
        return 1
    fi

    # Create extraction directory
    mkdir -p "$TMP_DIR/extract"

    # Extract the archive
    if ! tar -xzf "$TMP_DIR/oneclick.tar.gz" -C "$TMP_DIR/extract"; then
        show_error "Failed to extract update. Please try again later."
        rm -rf "$TMP_DIR"
        return 1
    fi

    # Backup current script
    local BACKUP_FILE="$SCRIPT_DIR/oneclick.sh.backup"
    show_info "Creating backup of current version at $BACKUP_FILE"
    cp "$SCRIPT_PATH" "$BACKUP_FILE"

    # Install the update
    show_info "Installing update..."
    cp "$TMP_DIR/extract/oneclick.sh" "$SCRIPT_PATH"
    chmod +x "$SCRIPT_PATH"

    # Cleanup
    rm -rf "$TMP_DIR"

    show_success "Update complete! Version $LATEST_VERSION is now installed."
    show_info "Restarting script in 3 seconds..."
    sleep 3

    # Restart the script
    exec "$SCRIPT_PATH"
    exit 0
}

# Display update menu
show_update_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         UPDATE MANAGEMENT              ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Check for Updates${NC}"
    echo -e "${GREEN}2. Show Current Version${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_RED}9. Exit Program${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle update menu choices
check_update_menu() {
    local choice

    while true; do
        show_update_menu
        read -r choice

        case $choice in
            1)
                check_for_updates
                press_any_key
                ;;
            2)
                show_success "Current version: $VERSION"
                show_success "Build date: $BUILD_DATE"
                press_any_key
                ;;
            0) break ;;
            9) exit_script ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}