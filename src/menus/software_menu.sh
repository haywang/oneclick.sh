# Software installation menu functions

# Display software installation menu
show_software_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}      SOFTWARE INSTALLATION            ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Install Git${NC}"
    echo -e "${GREEN}2. Install Zsh${NC}"
    echo -e "${GREEN}3. Install Oh-My-Zsh${NC}"
    echo -e "${GREEN}4. Install nvm${NC}"
    echo -e "${GREEN}5. Install Node.js${NC}"
    echo -e "${GREEN}6. Install pm2${NC}"
    echo -e "${GREEN}7. Install Nginx${NC}"
    echo -e "${GREEN}8. Install All Tools${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_RED}9. Exit Program${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle software installation menu choices
software_installation_menu() {
    local choice

    while true; do
        show_software_menu
        read choice

        case $choice in
            1) install_git "false" ;;
            2) install_zsh "false" ;;
            3) install_oh_my_zsh "false" ;;
            4) install_nvm "false" ;;
            5) install_node "false" ;;
            6) install_pm2 "false" ;;
            7) install_nginx "false" ;;
            8) install_all_tools ;;
            0) break ;;
            9) exit_script ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}