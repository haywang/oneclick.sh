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

        # 使用批量安装功能
        install_all_tools

        echo -e "${GREEN}All common tools have been installed!${NC}"
    else
        echo -e "${YELLOW}Installation cancelled.${NC}"
        sleep 2
    fi
}