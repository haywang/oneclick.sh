# Main menu functions

# Display main menu
show_main_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}       INTERACTIVE SHELL MENU           ${NC}"
    echo -e "${BOLD_GREEN}              by Austin                 ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. System Management${NC}"
    echo -e "${GREEN}2. Software Installation${NC}"
    echo -e "${GREEN}3. Operations Management${NC}"
    echo -e "${GREEN}4. File Transfer${NC}"
    echo -e "${GREEN}5. Git Operations${NC}"
    echo -e "${GREEN}6. Video Download${NC}"
    echo -e "${GREEN}7. Quick Install Common Tools${NC}"
    echo -e "${YELLOW}0. Exit${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Quick install common tools
install_common_tools() {
    show_success "Installing common tools..."

    # Update package list
    sudo apt-get update

    # Install common development tools
    sudo apt-get install -y build-essential git curl wget

    # Install system tools
    sudo apt-get install -y htop net-tools tree

    # Install text editors
    sudo apt-get install -y vim nano

    show_success "Common tools installed successfully"
    press_any_key
}

# Handle main menu choices
main_menu() {
    local choice

    while true; do
        show_main_menu
        read choice

        case $choice in
            1) system_management_menu ;;
            2) software_installation_menu ;;
            3) ops_management_menu ;;
            4) file_transfer_menu ;;
            5) git_operations_menu ;;
            6) video_download_menu ;;
            7) install_common_tools ;;
            0)
                echo -e "${GREEN}Thank you for using the system management tool!${NC}"
                exit 0
                ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}