# Software installation menu functions

# Display software installation menu
show_software_installation_menu() {
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
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle software installation menu choices
software_installation_menu() {
    local choice

    while true; do
        show_software_installation_menu
        read choice

        case $choice in
            1) install_git ;;
            2) install_zsh ;;
            3) install_oh_my_zsh ;;
            4) install_nvm ;;
            5) install_node ;;
            6) install_pm2 ;;
            7) install_nginx ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}