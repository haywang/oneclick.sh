#!/bin/bash

# Version information
VERSION="1.0.11"
BUILD_DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Create dist directory if it doesn't exist
mkdir -p dist

# Combine all source files into one
{
    # Add shebang
    echo "#!/bin/bash"
    echo ""

    # Add version information
    echo "# Version information"
    echo "VERSION=\"$VERSION\""
    echo "BUILD_DATE=\"$BUILD_DATE\""
    echo ""

    # Add utilities
    echo "# Utility functions"
    cat src/utils/colors.sh
    echo ""
    cat src/utils/common.sh
    echo ""
    cat src/utils/validators.sh
    echo ""

    # Add modules
    echo "# System management module"
    cat src/modules/system/user_management.sh
    echo ""
    cat src/modules/system/ufw_management.sh
    echo ""
    cat src/modules/system/time_management.sh
    echo ""

    echo "# Software installation module"
    cat src/modules/software/software_install.sh
    echo ""

    echo "# Operations management module"
    cat src/modules/ops/ops_management.sh
    echo ""

    echo "# File transfer module"
    cat src/modules/transfer/file_transfer.sh
    echo ""

    echo "# Git operations module"
    cat src/modules/git/git_operations.sh
    echo ""

    echo "# Video download module"
    cat src/modules/video/video_download.sh
    echo ""

    # Add menus
    echo "# Menu modules"
    cat src/menus/system_menu.sh
    echo ""
    cat src/menus/software_menu.sh
    echo ""
    cat src/menus/ops_menu.sh
    echo ""
    cat src/menus/transfer_menu.sh
    echo ""
    cat src/menus/git_menu.sh
    echo ""
    cat src/menus/video_menu.sh
    echo ""
    cat src/menus/macbook_menu.sh
    echo ""
    cat src/menus/update_menu.sh
    echo ""
    cat src/menus/quick_install_menu.sh
    echo ""
    cat src/menus/main_menu.sh
    echo ""

    # Add auto-update check at startup
    echo "# Auto-update check"
    echo "# Check for updates at startup if no arguments provided"
    echo "if [ \$# -eq 0 ]; then"
    echo "    # Display a startup message"
    echo "    echo -e \"${BOLD_CYAN}Checking for updates...${NC}\""
    echo ""
    echo "    # Run check_for_updates with debug=0 (silent mode)"
    echo "    check_for_updates 0"
    echo "    UPDATE_STATUS=\$?"
    echo ""
    echo "    if [ \$UPDATE_STATUS -eq 2 ]; then"
    echo "        # Update was performed and script restarted"
    echo "        exit 0"
    echo "    elif [ \$UPDATE_STATUS -eq 1 ]; then"
    echo "        # Error occurred during update check"
    echo "        echo -e \"${YELLOW}Update check skipped due to error.${NC}\""
    echo "        sleep 1"
    echo "    else"
    echo "        # No updates available"
    echo "        echo -e \"${GREEN}No updates available.${NC}\""
    echo "        sleep 1"
    echo "    fi"
    echo "    clear"
    echo "fi"
    echo ""

    # Add version flag handler
    echo "# Handle command line arguments"
    echo "if [[ \"\$1\" == \"--version\" || \"\$1\" == \"-v\" ]]; then"
    echo "    echo \"oneclick.sh version \$VERSION\""
    echo "    echo \"Build date: \$BUILD_DATE\""
    echo "    exit 0"
    echo "fi"
    echo ""

    # Add main entry point
    echo "# Start the application"
    echo "main_menu"
} > dist/oneclick.sh

# Make the script executable
chmod +x dist/oneclick.sh

echo "Build complete. The executable is available at dist/oneclick.sh"
echo "Version: $VERSION, Build date: $BUILD_DATE"