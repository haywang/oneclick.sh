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
    echo -e "${GREEN}8. Macbook Setup${NC}"
    echo -e "${GREEN}9. Check for Updates${NC}"
    echo -e "${BOLD_RED}0. Exit${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle main menu choices
main_menu() {
    local choice

    while true; do
        show_main_menu
        read -r choice

        case $choice in
            1) system_management_menu ;;
            2) software_installation_menu ;;
            3) ops_management_menu ;;
            4) file_transfer_menu ;;
            5) git_operations_menu ;;
            6) video_download_menu ;;
            7) quick_install_menu ;;
            8) macbook_setup_menu ;;
            9) check_update_menu ;;
            0) exit_script ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}