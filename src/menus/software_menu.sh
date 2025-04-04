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
    echo -e "${YELLOW}0. Back to main menu${NC}"
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
            1) install_git ;;
            2) install_zsh ;;
            3) install_oh_my_zsh ;;
            4) install_nvm ;;
            5) install_node ;;
            6) install_pm2 ;;
            7) install_nginx ;;
            0) break ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}

# Python tools installation
install_python_tools() {
    show_success "Installing Python tools..."

    # Install Python3 and pip3
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip

    # Install common Python packages
    pip3 install --upgrade pip
    pip3 install virtualenv
    pip3 install ipython
    pip3 install jupyter

    show_success "Python tools installed successfully"
    press_any_key
}

# System monitors installation
install_system_monitors() {
    show_success "Installing system monitoring tools..."

    # Install monitoring tools
    sudo apt-get update
    sudo apt-get install -y htop iotop iftop nmon

    show_success "System monitoring tools installed successfully"
    press_any_key
}