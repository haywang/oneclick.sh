# Quick install menu functions

# Display quick install menu
show_quick_install_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}      COMMON TOOLS INSTALLATION         ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}The following tools will be installed:${NC}"
    echo -e "${GREEN}1. Git - Version Control System${NC}"
    echo -e "${GREEN}2. Zsh - Enhanced Shell${NC}"
    echo -e "${GREEN}3. Oh-My-Zsh - Shell Framework${NC}"
    echo -e "${GREEN}4. nvm & Node.js - JavaScript Runtime${NC}"
    echo -e "${GREEN}5. pm2 - Process Manager${NC}"
    echo -e "${GREEN}6. Nginx - Web Server${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
}

# Handle quick install menu
quick_install_menu() {
    show_quick_install_menu
    read -p "Do you want to proceed with installation? (y/n): " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        echo -e "${CYAN}Starting installation...${NC}"

        install_git
        install_zsh
        install_oh_my_zsh
        install_nvm
        install_node
        install_pm2
        install_nginx

        echo -e "${GREEN}All common tools have been installed!${NC}"
        read -p "Press Enter to continue..."
    else
        echo -e "${YELLOW}Installation cancelled.${NC}"
        sleep 2
    fi
}