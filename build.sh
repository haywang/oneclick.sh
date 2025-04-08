#!/bin/bash

# Create dist directory if it doesn't exist
mkdir -p dist

# Combine all source files into one
{
    # Add shebang
    echo "#!/bin/bash"
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
    cat src/menus/git_menu.sh
    echo ""
    cat src/menus/quick_install_menu.sh
    echo ""
    cat src/menus/main_menu.sh
    echo ""

    # Add main entry point
    echo "# Start the application"
    echo "main_menu"
} > dist/oneclick.sh

# Make the script executable
chmod +x dist/oneclick.sh

echo "Build complete. The executable is available at dist/oneclick.sh"