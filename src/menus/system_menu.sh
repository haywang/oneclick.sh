# System management menu functions

# Display system management menu
show_system_management_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         SYSTEM MANAGEMENT             ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. User Management${NC}"
    echo -e "${GREEN}2. Port Management${NC}"
    echo -e "${GREEN}3. UFW Firewall${NC}"
    echo -e "${GREEN}4. System Monitor${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle system management menu choices
system_management_menu() {
    local choice

    while true; do
        show_system_management_menu
        read choice

        case $choice in
            1) user_management_menu ;;
            2) port_management_menu ;;
            3) ufw_management_menu ;;
            4) system_monitor_menu ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Display user management menu
show_user_management_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         USER MANAGEMENT              ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Add New User${NC}"
    echo -e "${GREEN}2. Delete User Only${NC}"
    echo -e "${GREEN}3. Delete User and Home Directory${NC}"
    echo -e "${GREEN}4. Delete User and All Files${NC}"
    echo -e "${GREEN}5. List All Users${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle user management menu choices
user_management_menu() {
    local choice

    while true; do
        show_user_management_menu
        read choice

        case $choice in
            1) add_new_user ;;
            2) delete_user_only ;;
            3) delete_user_and_home ;;
            4) delete_user_and_files ;;
            5) list_all_users ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}