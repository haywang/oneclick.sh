#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
BOLD_GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Function to display the main menu
show_main_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}          INTERACTIVE SHELL MENU        ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Setup Server${NC}"
    echo -e "${GREEN}2. Tools${NC}"
    echo -e "${GREEN}3. Diagnose${NC}"
    echo -e "${GREEN}0. Exit${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Function to display Setup Server submenu
show_setup_server_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}            SETUP SERVER               ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Add new user and set sudoer${NC}"
    echo -e "${GREEN}2. Install Git${NC}"
    echo -e "${GREEN}3. Install ZSH${NC}"
    echo -e "${GREEN}4. Install Oh-My-ZSH${NC}"
    echo -e "${GREEN}5. Install NVM${NC}"
    echo -e "${GREEN}6. Install Node${NC}"
    echo -e "${GREEN}7. Install PM2${NC}"
    echo -e "${GREEN}8. Install Nginx${NC}"
    echo -e "${GREEN}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Function to display Tools submenu
show_tools_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}               TOOLS                   ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. SSH${NC}"
    echo -e "${GREEN}2. Look port use${NC}"
    echo -e "${GREEN}3. SCP local to server${NC}"
    echo -e "${GREEN}4. SCP server to local${NC}"
    echo -e "${GREEN}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Function to display Diagnose submenu
show_diagnose_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}             DIAGNOSE                 ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Top${NC}"
    echo -e "${GREEN}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Function to add new user and set sudoer
add_new_user() {
    clear
    echo -e "${BOLD_GREEN}Add new user and set sudoer${NC}"
    echo -e "${GREEN}Enter username: ${NC}"
    read username

    # Check if username is provided
    if [ -z "$username" ]; then
        echo -e "${GREEN}Username cannot be empty. Please try again.${NC}"
        sleep 2
        return
    fi

    # Create user
    sudo adduser $username

    # Add user to sudoers
    sudo usermod -aG sudo $username

    echo -e "${GREEN}User $username has been added and set as sudoer.${NC}"
    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install Git
install_git() {
    clear
    echo -e "${BOLD_GREEN}Installing Git...${NC}"
    sudo apt update
    sudo apt install -y git
    echo -e "${GREEN}Git has been installed. Version: $(git --version)${NC}"
    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install ZSH
install_zsh() {
    clear
    echo -e "${BOLD_GREEN}Installing ZSH...${NC}"
    sudo apt update
    sudo apt install -y zsh
    echo -e "${GREEN}ZSH has been installed. Version: $(zsh --version)${NC}"
    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install Oh-My-ZSH
install_oh_my_zsh() {
    clear
    echo -e "${BOLD_GREEN}Installing Oh-My-ZSH...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${GREEN}Oh-My-ZSH has been installed.${NC}"
    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install NVM
install_nvm() {
    clear
    echo -e "${BOLD_GREEN}Installing NVM...${NC}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

    # Setup NVM in current shell
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    echo -e "${GREEN}NVM has been installed.${NC}"
    echo -e "${GREEN}Please restart your terminal or source your profile to use NVM.${NC}"
    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install Node
install_node() {
    clear
    echo -e "${BOLD_GREEN}Installing Node.js...${NC}"

    # Check if NVM is installed
    if [ ! -d "$HOME/.nvm" ]; then
        echo -e "${GREEN}NVM is not installed. Please install NVM first.${NC}"
        echo -e "${GREEN}Press any key to continue...${NC}"
        read -n 1
        return
    fi

    # Setup NVM in current shell
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Install Node.js LTS
    nvm install --lts

    echo -e "${GREEN}Node.js has been installed. Version: $(node -v)${NC}"
    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install PM2
install_pm2() {
    clear
    echo -e "${BOLD_GREEN}Installing PM2...${NC}"

    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        echo -e "${GREEN}Node.js is not installed. Please install Node.js first.${NC}"
        echo -e "${GREEN}Press any key to continue...${NC}"
        read -n 1
        return
    fi

    # Install PM2 globally
    npm install -g pm2

    echo -e "${GREEN}PM2 has been installed. Version: $(pm2 -v)${NC}"
    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install Nginx
install_nginx() {
    clear
    echo -e "${BOLD_GREEN}Installing Nginx...${NC}"
    sudo apt update
    sudo apt install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx

    echo -e "${GREEN}Nginx has been installed and started.${NC}"
    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Function for SSH
ssh_tool() {
    clear
    echo -e "${BOLD_GREEN}SSH Tool${NC}"
    echo -e "${GREEN}Enter server address (user@hostname): ${NC}"
    read server

    # Check if server is provided
    if [ -z "$server" ]; then
        echo -e "${GREEN}Server address cannot be empty. Please try again.${NC}"
        sleep 2
        return
    fi

    # Connect to server
    ssh $server

    echo -e "${GREEN}SSH session ended. Press any key to continue...${NC}"
    read -n 1
}

# Function to check port usage
check_port_usage() {
    clear
    echo -e "${BOLD_GREEN}Check Port Usage${NC}"
    echo -e "${GREEN}Enter port number (leave empty to show all): ${NC}"
    read port

    if [ -z "$port" ]; then
        # Show all open ports
        echo -e "${GREEN}Showing all open ports:${NC}"
        sudo netstat -tulpn
    else
        # Show specific port
        echo -e "${GREEN}Checking port $port:${NC}"
        sudo netstat -tulpn | grep ":$port "
    fi

    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Function for SCP from local to server
scp_local_to_server() {
    clear
    echo -e "${BOLD_GREEN}SCP: Local to Server${NC}"
    echo -e "${GREEN}Enter local file path: ${NC}"
    read local_path

    echo -e "${GREEN}Enter server destination (user@hostname:path): ${NC}"
    read server_path

    # Check if paths are provided
    if [ -z "$local_path" ] || [ -z "$server_path" ]; then
        echo -e "${GREEN}Both paths must be provided. Please try again.${NC}"
        sleep 2
        return
    fi

    # Transfer file
    scp "$local_path" "$server_path"

    echo -e "${GREEN}File transfer completed. Press any key to continue...${NC}"
    read -n 1
}

# Function for SCP from server to local
scp_server_to_local() {
    clear
    echo -e "${BOLD_GREEN}SCP: Server to Local${NC}"
    echo -e "${GREEN}Enter server file path (user@hostname:path): ${NC}"
    read server_path

    echo -e "${GREEN}Enter local destination path: ${NC}"
    read local_path

    # Check if paths are provided
    if [ -z "$server_path" ] || [ -z "$local_path" ]; then
        echo -e "${GREEN}Both paths must be provided. Please try again.${NC}"
        sleep 2
        return
    fi

    # Transfer file
    scp "$server_path" "$local_path"

    echo -e "${GREEN}File transfer completed. Press any key to continue...${NC}"
    read -n 1
}

# Function for Top command
top_command() {
    clear
    echo -e "${BOLD_GREEN}Running Top...${NC}"
    top
}

# Handle Setup Server menu options
setup_server_menu() {
    local choice

    while true; do
        show_setup_server_menu
        read choice

        case $choice in
            1) add_new_user ;;
            2) install_git ;;
            3) install_zsh ;;
            4) install_oh_my_zsh ;;
            5) install_nvm ;;
            6) install_node ;;
            7) install_pm2 ;;
            8) install_nginx ;;
            0) break ;;
            *) echo -e "${GREEN}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Handle Tools menu options
tools_menu() {
    local choice

    while true; do
        show_tools_menu
        read choice

        case $choice in
            1) ssh_tool ;;
            2) check_port_usage ;;
            3) scp_local_to_server ;;
            4) scp_server_to_local ;;
            0) break ;;
            *) echo -e "${GREEN}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Handle Diagnose menu options
diagnose_menu() {
    local choice

    while true; do
        show_diagnose_menu
        read choice

        case $choice in
            1) top_command ;;
            0) break ;;
            *) echo -e "${GREEN}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Main function
main() {
    local choice

    while true; do
        show_main_menu
        read choice

        case $choice in
            1) setup_server_menu ;;
            2) tools_menu ;;
            3) diagnose_menu ;;
            0) clear ; exit 0 ;;
            *) echo -e "${GREEN}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Start the script
main
