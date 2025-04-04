#!/bin/bash

# Source utility functions
source src/utils/colors.sh
source src/utils/common.sh
source src/utils/validators.sh

# Source functional modules first
source src/modules/system/user_management.sh
source src/modules/system/ufw_management.sh
source src/modules/software/software_install.sh
source src/modules/ops/ops_management.sh
source src/modules/transfer/file_transfer.sh
source src/modules/git/git_operations.sh
source src/modules/video/video_download.sh

# Source menu modules after their dependencies
source src/menus/main_menu.sh
source src/menus/system_menu.sh
source src/menus/software_menu.sh
source src/menus/ops_menu.sh
source src/menus/transfer_menu.sh
source src/menus/git_menu.sh
source src/menus/video_menu.sh

# Start the application
main_menu