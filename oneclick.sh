#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
BOLD_GREEN='\033[1;32m'
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD_CYAN='\033[1;36m'
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
    echo -e "${GREEN}4. PM2 Management${NC}"
    echo -e "${GREEN}5. YT-DLP Video Download${NC}"
    echo -e "${GREEN}6. Delete User Account${NC}"
    echo -e "${GREEN}7. Nginx Management${NC}"
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
    echo -e "${GREEN}3. SCP Tools${NC}"
    echo -e "${GREEN}4. Install Homebrew${NC}"
    echo -e "${GREEN}5. Git Remove Cached Directory${NC}"
    echo -e "${GREEN}6. Rsync Tools${NC}"
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

# Function to display PM2 Management submenu
show_pm2_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}           PM2 MANAGEMENT              ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Start Application${NC}"
    echo -e "${GREEN}2. List All Applications${NC}"
    echo -e "${GREEN}3. Stop Application${NC}"
    echo -e "${GREEN}4. Restart Application${NC}"
    echo -e "${GREEN}5. Reload Application${NC}"
    echo -e "${GREEN}6. Delete Application${NC}"
    echo -e "${GREEN}7. Show Logs${NC}"
    echo -e "${GREEN}8. Monitor Applications${NC}"
    echo -e "${GREEN}9. Setup Startup Script${NC}"
    echo -e "${GREEN}10. Save Current Process List${NC}"
    echo -e "${GREEN}11. Update PM2${NC}"
    echo -e "${GREEN}12. Kill PM2 Daemon${NC}"
    echo -e "${GREEN}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Function to display YT-DLP submenu
show_ytdlp_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         YT-DLP VIDEO DOWNLOAD         ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Install/Update YT-DLP${NC}"
    echo -e "${GREEN}2. Download Single Video${NC}"
    echo -e "${GREEN}3. Download Playlist${NC}"
    echo -e "${GREEN}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Function to display Rsync submenu
show_rsync_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}            RSYNC TOOLS               ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Sync Local -> Remote${NC}"
    echo -e "${GREEN}2. Sync Remote -> Local${NC}"
    echo -e "${GREEN}3. Sync Local Directory${NC}"
    echo -e "${GREEN}4. Backup with Timestamp${NC}"
    echo -e "${GREEN}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Function to display SCP submenu
show_scp_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}            SCP TOOLS                 ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Copy File: Local -> Remote${NC}"
    echo -e "${GREEN}2. Copy File: Remote -> Local${NC}"
    echo -e "${GREEN}3. Copy Directory: Local -> Remote${NC}"
    echo -e "${GREEN}4. Copy Directory: Remote -> Local${NC}"
    echo -e "${GREEN}5. Copy Multiple Files${NC}"
    echo -e "${GREEN}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Function to display Delete User submenu
show_delete_user_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         DELETE USER ACCOUNT           ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Delete user only${NC}"
    echo -e "${GREEN}2. Delete user and home directory${NC}"
    echo -e "${GREEN}3. Delete user and all files${NC}"
    echo -e "${GREEN}4. List all users${NC}"
    echo -e "${GREEN}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Function to handle SCP operations
scp_tools() {
    local choice

    while true; do
        show_scp_menu
        read choice

        case $choice in
            1) scp_file_to_remote ;;
            2) scp_file_from_remote ;;
            3) scp_directory_to_remote ;;
            4) scp_directory_from_remote ;;
            5) scp_multiple_files ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Function for copying single file to remote
scp_file_to_remote() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy File to Remote${NC}"
    echo -e "${CYAN}Enter local file path: ${NC}"
    read local_path

    if [ ! -f "$local_path" ]; then
        echo -e "${BOLD_RED}Error: File does not exist.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Enter remote destination (user@host:path): ${NC}"
    read remote_path

    if [ -z "$local_path" ] || [ -z "$remote_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Copying file...${NC}"
    scp -p "$local_path" "$remote_path"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}File copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for copying single file from remote
scp_file_from_remote() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy File from Remote${NC}"
    echo -e "${CYAN}Enter remote file path (user@host:path): ${NC}"
    read remote_path
    echo -e "${CYAN}Enter local destination path: ${NC}"
    read local_path

    if [ -z "$remote_path" ] || [ -z "$local_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Copying file...${NC}"
    scp -p "$remote_path" "$local_path"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}File copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for copying directory to remote
scp_directory_to_remote() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy Directory to Remote${NC}"
    echo -e "${CYAN}Enter local directory path: ${NC}"
    read local_path

    if [ ! -d "$local_path" ]; then
        echo -e "${BOLD_RED}Error: Directory does not exist.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Enter remote destination (user@host:path): ${NC}"
    read remote_path

    if [ -z "$local_path" ] || [ -z "$remote_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select copy options:${NC}"
    echo -e "${GREEN}1. Copy directory contents${NC}"
    echo -e "${GREEN}2. Copy directory itself${NC}"
    read -r copy_option

    echo -e "${CYAN}Copying directory...${NC}"
    case $copy_option in
        1)
            scp -rp "$local_path"/* "$remote_path"
            ;;
        2)
            scp -rp "$local_path" "$remote_path"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using default (copy directory itself)${NC}"
            scp -rp "$local_path" "$remote_path"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Directory copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for copying directory from remote
scp_directory_from_remote() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy Directory from Remote${NC}"
    echo -e "${CYAN}Enter remote directory path (user@host:path): ${NC}"
    read remote_path
    echo -e "${CYAN}Enter local destination path: ${NC}"
    read local_path

    if [ -z "$remote_path" ] || [ -z "$local_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select copy options:${NC}"
    echo -e "${GREEN}1. Copy directory contents${NC}"
    echo -e "${GREEN}2. Copy directory itself${NC}"
    read -r copy_option

    echo -e "${CYAN}Copying directory...${NC}"
    case $copy_option in
        1)
            mkdir -p "$local_path"
            scp -rp "$remote_path"/* "$local_path"
            ;;
        2)
            scp -rp "$remote_path" "$local_path"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using default (copy directory itself)${NC}"
            scp -rp "$remote_path" "$local_path"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Directory copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for copying multiple files
scp_multiple_files() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy Multiple Files${NC}"
    echo -e "${CYAN}Select transfer direction:${NC}"
    echo -e "${GREEN}1. Local -> Remote${NC}"
    echo -e "${GREEN}2. Remote -> Local${NC}"
    read -r direction

    case $direction in
        1)
            echo -e "${CYAN}Enter local files (space-separated): ${NC}"
            read -r local_files
            echo -e "${CYAN}Enter remote destination (user@host:path): ${NC}"
            read -r remote_path

            if [ -z "$local_files" ] || [ -z "$remote_path" ]; then
                echo -e "${BOLD_RED}Both source files and destination must be provided.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return 1
            fi

            echo -e "${CYAN}Copying files...${NC}"
            scp -p $local_files "$remote_path"
            ;;
        2)
            echo -e "${CYAN}Enter remote files (space-separated, format: user@host:path/to/file): ${NC}"
            read -r remote_files
            echo -e "${CYAN}Enter local destination directory: ${NC}"
            read -r local_path

            if [ -z "$remote_files" ] || [ -z "$local_path" ]; then
                echo -e "${BOLD_RED}Both source files and destination must be provided.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return 1
            fi

            echo -e "${CYAN}Copying files...${NC}"
            scp -p $remote_files "$local_path"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option.${NC}"
            echo -e "${CYAN}Press any key to continue...${NC}"
            read -n 1
            return 1
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Files copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to add new user and set sudoer
add_new_user() {
    clear
    echo -e "${BOLD_GREEN}Add new user and set sudoer${NC}"
    echo -e "${CYAN}Enter username: ${NC}"
    read username

    # Check if username is provided
    if [ -z "$username" ]; then
        echo -e "${BOLD_RED}Username cannot be empty. Please try again.${NC}"
        sleep 2
        return
    fi

    # Create user
    sudo adduser $username

    # Add user to sudoers
    sudo usermod -aG sudo $username

    echo -e "${GREEN}User $username has been added and set as sudoer.${NC}"
    echo -e "${CYAN}Press any key to continue...${NC}"
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

    # Check if ZSH is already installed
    if command -v zsh &> /dev/null; then
        echo -e "${CYAN}ZSH is already installed. Version: $(zsh --version)${NC}"
    else
        # Install ZSH based on the system
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            if command -v brew &> /dev/null; then
                echo -e "${CYAN}Installing ZSH using Homebrew...${NC}"
                brew install zsh
            else
                echo -e "${CYAN}Installing ZSH using MacPorts...${NC}"
                sudo port install zsh zsh-completions
            fi
        else
            # Linux systems
            if command -v apt &> /dev/null; then
                echo -e "${CYAN}Installing ZSH using apt...${NC}"
                sudo apt update
                sudo apt install -y zsh
            elif command -v yum &> /dev/null; then
                echo -e "${CYAN}Installing ZSH using yum...${NC}"
                sudo yum update
                sudo yum install -y zsh
            elif command -v dnf &> /dev/null; then
                echo -e "${CYAN}Installing ZSH using dnf...${NC}"
                sudo dnf install -y zsh
            elif command -v pacman &> /dev/null; then
                echo -e "${CYAN}Installing ZSH using pacman...${NC}"
                sudo pacman -S zsh
            else
                echo -e "${BOLD_RED}Unsupported package manager. Please install ZSH manually.${NC}"
                return 1
            fi
        fi
    fi

    # Verify ZSH installation
    if command -v zsh &> /dev/null; then
        echo -e "${GREEN}ZSH has been installed successfully. Version: $(zsh --version)${NC}"

        # Check if ZSH is already the default shell
        if [ "$SHELL" = "$(which zsh)" ]; then
            echo -e "${CYAN}ZSH is already your default shell.${NC}"
        else
            echo -e "${CYAN}Setting ZSH as your default shell...${NC}"

            # Add ZSH to authorized shells if not already there
            if ! grep -q "$(which zsh)" /etc/shells; then
                echo -e "${CYAN}Adding ZSH to authorized shells...${NC}"
                sudo sh -c "echo $(which zsh) >> /etc/shells"
            fi

            # Set ZSH as default shell
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS
                if [[ "$(uname -m)" == "arm64" ]]; then
                    # M1 Macs
                    chsh -s $(which zsh)
                else
                    # Intel Macs
                    chsh -s /usr/local/bin/zsh
                fi
            else
                # Linux systems
                chsh -s $(which zsh)
            fi

            echo -e "${GREEN}ZSH has been set as your default shell.${NC}"
            echo -e "${YELLOW}Please log out and log back in for the changes to take effect.${NC}"
        fi
    else
        echo -e "${BOLD_RED}Failed to install ZSH. Please check the error messages above.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install Oh-My-ZSH
install_oh_my_zsh() {
    clear
    echo -e "${BOLD_GREEN}Installing Oh-My-ZSH...${NC}"

    # Check if ZSH is installed first
    if ! command -v zsh &> /dev/null; then
        echo -e "${BOLD_RED}ZSH is not installed. Please install ZSH first.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Check if Oh My Zsh is already installed
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${CYAN}Oh My Zsh is already installed.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 0
    fi

    # Try different installation methods
    echo -e "${CYAN}Attempting to install Oh My Zsh...${NC}"

    # Method 1: Using curl (preferred)
    if command -v curl &> /dev/null; then
        echo -e "${CYAN}Installing using curl...${NC}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Method 2: Using wget
    elif command -v wget &> /dev/null; then
        echo -e "${CYAN}Installing using wget...${NC}"
        sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Method 3: Using fetch (BSD systems)
    elif command -v fetch &> /dev/null; then
        echo -e "${CYAN}Installing using fetch...${NC}"
        sh -c "$(fetch -o - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo -e "${BOLD_RED}No supported download method found (curl, wget, or fetch).${NC}"
        echo -e "${YELLOW}Please install one of these tools and try again.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Check if installation was successful
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${GREEN}Oh My Zsh has been installed successfully!${NC}"

        # Backup existing .zshrc if it exists
        if [ -f "$HOME/.zshrc" ]; then
            echo -e "${CYAN}Backing up existing .zshrc to .zshrc.pre-oh-my-zsh${NC}"
            mv "$HOME/.zshrc" "$HOME/.zshrc.pre-oh-my-zsh"
        fi

        # Create new .zshrc
        echo -e "${CYAN}Creating new .zshrc file...${NC}"
        cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"

        echo -e "${GREEN}Installation complete!${NC}"
        echo -e "${YELLOW}Please restart your terminal to apply changes.${NC}"
        echo -e "${CYAN}Your old .zshrc has been backed up as .zshrc.pre-oh-my-zsh${NC}"
    else
        echo -e "${BOLD_RED}Failed to install Oh My Zsh. Please check the error messages above.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install NVM
install_nvm() {
    clear
    echo -e "${BOLD_GREEN}Installing NVM...${NC}"

    # Check if NVM is already installed
    if [ -d "$HOME/.nvm" ]; then
        echo -e "${CYAN}NVM is already installed.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 0
    fi

    # Check for required tools
    if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
        echo -e "${BOLD_RED}Neither curl nor wget is installed. Please install one of them first.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Try different installation methods
    echo -e "${CYAN}Attempting to install NVM...${NC}"

    # Method 1: Using curl (preferred)
    if command -v curl &> /dev/null; then
        echo -e "${CYAN}Installing using curl...${NC}"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    # Method 2: Using wget
    elif command -v wget &> /dev/null; then
        echo -e "${CYAN}Installing using wget...${NC}"
        wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    fi

    # Check if installation was successful
    if [ -d "$HOME/.nvm" ]; then
        echo -e "${GREEN}NVM has been installed successfully!${NC}"

        # Setup NVM in current shell
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

        # Add NVM to shell profile if not already there
        local shell_profile
        if [[ "$SHELL" == *"zsh"* ]]; then
            shell_profile="$HOME/.zshrc"
        else
            shell_profile="$HOME/.bashrc"
        fi

        if ! grep -q "NVM_DIR" "$shell_profile"; then
            echo -e "${CYAN}Adding NVM configuration to $shell_profile...${NC}"
            cat >> "$shell_profile" << 'EOF'

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF
        fi

        # Test NVM installation
        if command -v nvm &> /dev/null; then
            echo -e "${GREEN}NVM is working correctly. Version: $(nvm --version)${NC}"
            echo -e "${YELLOW}Please restart your terminal or run 'source $shell_profile' to use NVM.${NC}"
        else
            echo -e "${BOLD_RED}NVM installation completed but command not found.${NC}"
            echo -e "${YELLOW}Please restart your terminal or run 'source $shell_profile' to use NVM.${NC}"
        fi
    else
        echo -e "${BOLD_RED}Failed to install NVM. Please check the error messages above.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
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
    echo -e "${CYAN}Enter server address (user@hostname): ${NC}"
    read server

    # Check if server is provided
    if [ -z "$server" ]; then
        echo -e "${BOLD_RED}Server address cannot be empty. Please try again.${NC}"
        sleep 2
        return
    fi

    # Connect to server
    ssh $server

    echo -e "${CYAN}SSH session ended. Press any key to continue...${NC}"
    read -n 1
}

# Function to check port usage
check_port_usage() {
    clear
    echo -e "${BOLD_GREEN}Check Port Usage${NC}"
    echo -e "${CYAN}Enter port number (leave empty to show all): ${NC}"
    read port

    # Function to check which command is available
    check_command() {
        if command -v netstat &> /dev/null; then
            echo "netstat"
        elif command -v ss &> /dev/null; then
            echo "ss"
        elif command -v lsof &> /dev/null; then
            echo "lsof"
        else
            echo ""
        fi
    }

    # Get available command
    CMD=$(check_command)

    if [ -z "$CMD" ]; then
        echo -e "${BOLD_RED}No port checking command found. Installing net-tools...${NC}"
        if command -v apt &> /dev/null; then
            sudo apt update
            sudo apt install -y net-tools
            CMD="netstat"
        elif command -v yum &> /dev/null; then
            sudo yum install -y net-tools
            CMD="netstat"
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y net-tools
            CMD="netstat"
        elif command -v pacman &> /dev/null; then
            sudo pacman -S net-tools
            CMD="netstat"
        else
            echo -e "${BOLD_RED}Unable to install net-tools. Please install it manually.${NC}"
            echo -e "${CYAN}Press any key to continue...${NC}"
            read -n 1
            return 1
        fi
    fi

    # Show port information based on available command
    case $CMD in
        "netstat")
            if [ -z "$port" ]; then
                echo -e "${CYAN}Showing all open ports using netstat:${NC}"
                sudo netstat -tulpn
            else
                echo -e "${CYAN}Checking port $port using netstat:${NC}"
                sudo netstat -tulpn | grep ":$port "
            fi
            ;;
        "ss")
            if [ -z "$port" ]; then
                echo -e "${CYAN}Showing all open ports using ss:${NC}"
                sudo ss -tulpn
            else
                echo -e "${CYAN}Checking port $port using ss:${NC}"
                sudo ss -tulpn | grep ":$port "
            fi
            ;;
        "lsof")
            if [ -z "$port" ]; then
                echo -e "${CYAN}Showing all open ports using lsof:${NC}"
                sudo lsof -i -P -n | grep LISTEN
            else
                echo -e "${CYAN}Checking port $port using lsof:${NC}"
                sudo lsof -i:$port -P -n | grep LISTEN
            fi
            ;;
    esac

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for SCP from local to server
scp_local_to_server() {
    clear
    echo -e "${BOLD_GREEN}SCP: Local to Server${NC}"
    echo -e "${CYAN}Enter local file path: ${NC}"
    read local_path

    echo -e "${CYAN}Enter server destination (user@hostname:path): ${NC}"
    read server_path

    # Check if paths are provided
    if [ -z "$local_path" ] || [ -z "$server_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided. Please try again.${NC}"
        sleep 2
        return
    fi

    # Transfer file
    scp "$local_path" "$server_path"

    echo -e "${GREEN}File transfer completed.${NC}"
    echo -e "${CYAN}Press any key to continue...${NC}"
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

# Function to install Homebrew
install_homebrew() {
    clear
    echo -e "${BOLD_GREEN}Installing Homebrew...${NC}"

    # Check if running on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo -e "${BOLD_RED}This system is not macOS. Homebrew installation is primarily for macOS.${NC}"
        echo -e "${YELLOW}If you're on Linux, you can still install Homebrew, but it's not recommended.${NC}"
        echo -e "${CYAN}Do you want to continue anyway? (y/N): ${NC}"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            echo -e "${CYAN}Installation cancelled.${NC}"
            echo -e "${CYAN}Press any key to continue...${NC}"
            read -n 1
            return
        fi
    fi

    # Function to fix Homebrew permissions
    fix_homebrew_permissions() {
        local homebrew_path="$1"
        echo -e "${YELLOW}Fixing Homebrew permissions...${NC}"
        if [ -d "$homebrew_path" ]; then
            echo -e "${CYAN}Changing ownership of $homebrew_path to $USER...${NC}"
            sudo chown -R "$USER" "$homebrew_path"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Permissions fixed successfully.${NC}"
                return 0
            else
                echo -e "${BOLD_RED}Failed to fix permissions.${NC}"
                return 1
            fi
        else
            echo -e "${BOLD_RED}Homebrew path $homebrew_path does not exist.${NC}"
            return 1
        fi
    }

    # Check if Homebrew is already installed
    if command -v brew &> /dev/null; then
        echo -e "${CYAN}Homebrew is already installed.${NC}"
        echo -e "${CYAN}Current version: $(brew --version)${NC}"

        # Check Homebrew path and permissions
        local homebrew_path
        if [[ "$(uname -m)" == "arm64" ]]; then
            homebrew_path="/opt/homebrew"
        else
            homebrew_path="/usr/local"
        fi

        # Check if user has write permissions
        if ! [ -w "$homebrew_path" ]; then
            echo -e "${YELLOW}Warning: $homebrew_path is not writable.${NC}"
            echo -e "${CYAN}Do you want to fix permissions? (Y/n): ${NC}"
            read -r response
            if [[ "$response" =~ ^[Yy]$ ]] || [[ -z "$response" ]]; then
                fix_homebrew_permissions "$homebrew_path"
            fi
        fi

        echo -e "${YELLOW}Do you want to update Homebrew? (y/N): ${NC}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            echo -e "${CYAN}Updating Homebrew...${NC}"
            if brew update; then
                echo -e "${GREEN}Homebrew has been updated successfully.${NC}"
            else
                echo -e "${BOLD_RED}Failed to update Homebrew. Checking permissions...${NC}"
                fix_homebrew_permissions "$homebrew_path"
                echo -e "${CYAN}Trying update again...${NC}"
                if brew update; then
                    echo -e "${GREEN}Homebrew has been updated successfully after fixing permissions.${NC}"
                else
                    echo -e "${BOLD_RED}Update failed. Please check the error messages above.${NC}"
                fi
            fi
        fi
    else
        # Check for required tools
        if ! command -v curl &> /dev/null; then
            echo -e "${BOLD_RED}curl is required but not installed.${NC}"
            echo -e "${CYAN}Press any key to continue...${NC}"
            read -n 1
            return 1
        fi

        echo -e "${CYAN}Installing Homebrew...${NC}"
        # Install Homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Check if installation was successful
        if command -v brew &> /dev/null; then
            echo -e "${GREEN}Homebrew has been installed successfully!${NC}"

            # Add Homebrew to PATH for Apple Silicon Macs
            if [[ "$(uname -m)" == "arm64" ]]; then
                echo -e "${CYAN}Setting up Homebrew for Apple Silicon Mac...${NC}"
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi

            # Display Homebrew version
            echo -e "${CYAN}Installed version: $(brew --version)${NC}"
        else
            echo -e "${BOLD_RED}Failed to install Homebrew. Please check the error messages above.${NC}"
        fi
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to remove cached directory from git
git_rm_cached_directory() {
    clear
    echo -e "${BOLD_GREEN}Git Remove Cached Directory${NC}"

    # Check if current directory is a git repository
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e "${BOLD_RED}Error: Current directory is not a git repository.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Enter directory name to remove from git cache: ${NC}"
    read dir_name

    # Check if directory name is provided
    if [ -z "$dir_name" ]; then
        echo -e "${BOLD_RED}Directory name cannot be empty. Please try again.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Check if directory exists
    if [ ! -d "$dir_name" ]; then
        echo -e "${BOLD_RED}Directory '$dir_name' does not exist.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${YELLOW}Are you sure you want to remove '$dir_name' from git cache? (y/N): ${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        if git rm -r --cached "$dir_name"; then
            echo -e "${GREEN}Successfully removed '$dir_name' from git cache.${NC}"
            echo -e "${YELLOW}Remember to commit this change and push to remote repository.${NC}"
        else
            echo -e "${BOLD_RED}Failed to remove directory from git cache.${NC}"
        fi
    else
        echo -e "${CYAN}Operation cancelled.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# PM2 Management Functions
pm2_start_app() {
    clear
    echo -e "${BOLD_GREEN}Start PM2 Application${NC}"
    echo -e "${CYAN}Enter application path (e.g., app.js): ${NC}"
    read app_path

    if [ -z "$app_path" ]; then
        echo -e "${BOLD_RED}Application path cannot be empty.${NC}"
    else
        echo -e "${CYAN}Enter application name (optional, press Enter to skip): ${NC}"
        read app_name

        if [ -n "$app_name" ]; then
            pm2 start "$app_path" --name "$app_name"
        else
            pm2 start "$app_path"
        fi

        echo -e "${GREEN}Application started.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_list_apps() {
    clear
    echo -e "${BOLD_GREEN}Listing All PM2 Applications${NC}"
    pm2 list
    echo -e "\n${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_stop_app() {
    clear
    echo -e "${BOLD_GREEN}Stop PM2 Application${NC}"
    pm2 list
    echo -e "\n${CYAN}Enter application name/id to stop (or 'all' for all apps): ${NC}"
    read app_id

    if [ -n "$app_id" ]; then
        pm2 stop "$app_id"
        echo -e "${GREEN}Application(s) stopped.${NC}"
    else
        echo -e "${BOLD_RED}Application name/id cannot be empty.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_restart_app() {
    clear
    echo -e "${BOLD_GREEN}Restart PM2 Application${NC}"
    pm2 list
    echo -e "\n${CYAN}Enter application name/id to restart (or 'all' for all apps): ${NC}"
    read app_id

    if [ -n "$app_id" ]; then
        pm2 restart "$app_id"
        echo -e "${GREEN}Application(s) restarted.${NC}"
    else
        echo -e "${BOLD_RED}Application name/id cannot be empty.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_reload_app() {
    clear
    echo -e "${BOLD_GREEN}Reload PM2 Application (Zero Downtime)${NC}"
    pm2 list
    echo -e "\n${CYAN}Enter application name/id to reload (or 'all' for all apps): ${NC}"
    read app_id

    if [ -n "$app_id" ]; then
        pm2 reload "$app_id"
        echo -e "${GREEN}Application(s) reloaded.${NC}"
    else
        echo -e "${BOLD_RED}Application name/id cannot be empty.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_delete_app() {
    clear
    echo -e "${BOLD_GREEN}Delete PM2 Application${NC}"
    pm2 list
    echo -e "\n${CYAN}Enter application name/id to delete (or 'all' for all apps): ${NC}"
    read app_id

    if [ -n "$app_id" ]; then
        echo -e "${YELLOW}Are you sure you want to delete '$app_id'? (y/N): ${NC}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            pm2 delete "$app_id"
            echo -e "${GREEN}Application(s) deleted.${NC}"
        else
            echo -e "${CYAN}Operation cancelled.${NC}"
        fi
    else
        echo -e "${BOLD_RED}Application name/id cannot be empty.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_show_logs() {
    clear
    echo -e "${BOLD_GREEN}Show PM2 Logs${NC}"
    echo -e "${CYAN}Options:${NC}"
    echo -e "${GREEN}1. Show all logs${NC}"
    echo -e "${GREEN}2. Show specific application logs${NC}"
    echo -e "${GREEN}3. Show last N lines${NC}"
    echo -e "${GREEN}0. Back${NC}"
    read -r choice

    case $choice in
        1)
            pm2 logs
            ;;
        2)
            pm2 list
            echo -e "\n${CYAN}Enter application name/id: ${NC}"
            read app_id
            if [ -n "$app_id" ]; then
                pm2 logs "$app_id"
            fi
            ;;
        3)
            echo -e "${CYAN}Enter number of lines: ${NC}"
            read lines
            if [ -n "$lines" ]; then
                pm2 logs --lines "$lines"
            fi
            ;;
        0)
            return
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option.${NC}"
            ;;
    esac
}

pm2_monitor() {
    clear
    echo -e "${BOLD_GREEN}Monitoring PM2 Applications${NC}"
    pm2 monit
}

pm2_setup_startup() {
    clear
    echo -e "${BOLD_GREEN}Setting up PM2 Startup Script${NC}"
    pm2 startup
    echo -e "${YELLOW}Follow the instructions above if any command needs to be executed.${NC}"
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_save_process_list() {
    clear
    echo -e "${BOLD_GREEN}Saving Current Process List${NC}"
    pm2 save
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_update() {
    clear
    echo -e "${BOLD_GREEN}Updating PM2${NC}"
    echo -e "${CYAN}Installing latest PM2 version...${NC}"
    npm install pm2@latest -g

    echo -e "${CYAN}Updating PM2 in-memory...${NC}"
    pm2 update

    echo -e "${GREEN}PM2 has been updated to the latest version.${NC}"
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to kill PM2 daemon
pm2_kill() {
    clear
    echo -e "${BOLD_GREEN}Kill PM2 Daemon${NC}"
    echo -e "${YELLOW}Warning: This will stop all running PM2 processes and kill the PM2 daemon.${NC}"
    echo -e "${YELLOW}Are you sure you want to continue? (y/N): ${NC}"
    read -r response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo -e "${CYAN}Killing PM2 daemon...${NC}"
        pm2 kill
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}PM2 daemon has been killed successfully.${NC}"
        else
            echo -e "${BOLD_RED}Failed to kill PM2 daemon.${NC}"
        fi
    else
        echo -e "${CYAN}Operation cancelled.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to install or update yt-dlp
install_ytdlp() {
    clear
    echo -e "${BOLD_GREEN}Installing/Updating YT-DLP...${NC}"

    # Check if Homebrew is available (for macOS)
    if command -v brew &> /dev/null; then
        echo -e "${CYAN}Installing/Updating YT-DLP using Homebrew...${NC}"
        brew install yt-dlp || brew upgrade yt-dlp
    else
        # For other systems, try using pip
        if command -v pip3 &> /dev/null; then
            echo -e "${CYAN}Installing/Updating YT-DLP using pip3...${NC}"
            pip3 install -U yt-dlp
        elif command -v pip &> /dev/null; then
            echo -e "${CYAN}Installing/Updating YT-DLP using pip...${NC}"
            pip install -U yt-dlp
        else
            echo -e "${BOLD_RED}Neither Homebrew nor pip is available. Please install pip first.${NC}"
            echo -e "${CYAN}Press any key to continue...${NC}"
            read -n 1
            return 1
        fi
    fi

    # Verify installation
    if command -v yt-dlp &> /dev/null; then
        echo -e "${GREEN}YT-DLP installed/updated successfully.${NC}"
        echo -e "${CYAN}Current version: $(yt-dlp --version)${NC}"
    else
        echo -e "${BOLD_RED}Failed to install/update YT-DLP.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to download single video
download_single_video() {
    clear
    echo -e "${BOLD_GREEN}Download Single Video${NC}"
    echo -e "${CYAN}Enter video URL: ${NC}"
    read video_url

    if [ -z "$video_url" ]; then
        echo -e "${BOLD_RED}URL cannot be empty.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Choose video quality:${NC}"
    echo -e "${GREEN}1. Best quality MP4 (video + audio)${NC}"
    echo -e "${GREEN}2. 1080p MP4${NC}"
    echo -e "${GREEN}3. 720p MP4${NC}"
    echo -e "${GREEN}4. Audio only (MP3)${NC}"
    read -r quality_choice

    # 通用参数：合并后转换为mp4，显示格式列表
    local common_opts="--merge-output-format mp4 --list-formats"

    case $quality_choice in
        1)
            echo -e "${CYAN}Available formats:${NC}"
            yt-dlp $common_opts "$video_url"
            echo -e "${CYAN}Downloading best MP4 quality...${NC}"
            yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" "$video_url"
            ;;
        2)
            echo -e "${CYAN}Available formats:${NC}"
            yt-dlp $common_opts "$video_url"
            echo -e "${CYAN}Downloading 1080p MP4...${NC}"
            yt-dlp -f "bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[height<=1080][ext=mp4]/best[height<=1080]" "$video_url"
            ;;
        3)
            echo -e "${CYAN}Available formats:${NC}"
            yt-dlp $common_opts "$video_url"
            echo -e "${CYAN}Downloading 720p MP4...${NC}"
            yt-dlp -f "bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]/best[height<=720][ext=mp4]/best[height<=720]" "$video_url"
            ;;
        4)
            echo -e "${CYAN}Downloading audio only...${NC}"
            yt-dlp -f "bestaudio" -x --audio-format mp3 "$video_url"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid choice. Using best MP4 quality...${NC}"
            yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" "$video_url"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Download completed successfully.${NC}"
    else
        echo -e "${BOLD_RED}Download failed. Please check the URL and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to download playlist
download_playlist() {
    clear
    echo -e "${BOLD_GREEN}Download Playlist${NC}"
    echo -e "${CYAN}Enter playlist URL: ${NC}"
    read playlist_url

    if [ -z "$playlist_url" ]; then
        echo -e "${BOLD_RED}URL cannot be empty.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Choose download options:${NC}"
    echo -e "${GREEN}1. Download entire playlist${NC}"
    echo -e "${GREEN}2. Download from specific video${NC}"
    echo -e "${GREEN}3. Download specific range${NC}"
    read -r playlist_choice

    # 通用参数：合并后转换为mp4
    local format_opts="-f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best --merge-output-format mp4"

    case $playlist_choice in
        1)
            echo -e "${CYAN}Downloading entire playlist in MP4 format...${NC}"
            yt-dlp $format_opts "$playlist_url"
            ;;
        2)
            echo -e "${CYAN}Enter start video number: ${NC}"
            read start_number
            if [ -n "$start_number" ]; then
                echo -e "${CYAN}Downloading playlist from video $start_number in MP4 format...${NC}"
                yt-dlp $format_opts --playlist-start $start_number "$playlist_url"
            fi
            ;;
        3)
            echo -e "${CYAN}Enter start video number: ${NC}"
            read start_number
            echo -e "${CYAN}Enter end video number: ${NC}"
            read end_number
            if [ -n "$start_number" ] && [ -n "$end_number" ]; then
                echo -e "${CYAN}Downloading playlist from video $start_number to $end_number in MP4 format...${NC}"
                yt-dlp $format_opts --playlist-start $start_number --playlist-end $end_number "$playlist_url"
            fi
            ;;
        *)
            echo -e "${BOLD_RED}Invalid choice. Downloading entire playlist in MP4 format...${NC}"
            yt-dlp $format_opts "$playlist_url"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Playlist download completed successfully.${NC}"
    else
        echo -e "${BOLD_RED}Download failed. Please check the URL and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to handle rsync operations
rsync_tools() {
    local choice

    while true; do
        show_rsync_menu
        read choice

        case $choice in
            1) rsync_local_to_remote ;;
            2) rsync_remote_to_local ;;
            3) rsync_local_directory ;;
            4) rsync_backup_timestamp ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Function for rsync local to remote
rsync_local_to_remote() {
    clear
    echo -e "${BOLD_GREEN}Rsync: Local to Remote${NC}"
    echo -e "${CYAN}Enter local source path: ${NC}"
    read local_path
    echo -e "${CYAN}Enter remote destination (user@host:path): ${NC}"
    read remote_path

    if [ -z "$local_path" ] || [ -z "$remote_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select sync options:${NC}"
    echo -e "${GREEN}1. Simple sync (no delete)${NC}"
    echo -e "${GREEN}2. Mirror (with delete)${NC}"
    echo -e "${GREEN}3. Dry run (test only)${NC}"
    read -r sync_option

    local rsync_opts="-avzh --progress"
    case $sync_option in
        1)
            echo -e "${CYAN}Performing simple sync...${NC}"
            ;;
        2)
            echo -e "${YELLOW}Warning: Mirror mode will delete files in destination that don't exist in source${NC}"
            echo -e "${CYAN}Continue? (y/N): ${NC}"
            read -r confirm
            if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
                echo -e "${CYAN}Operation cancelled.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return
            fi
            rsync_opts="$rsync_opts --delete"
            ;;
        3)
            rsync_opts="$rsync_opts --dry-run"
            echo -e "${CYAN}Performing dry run (no actual changes)...${NC}"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using simple sync.${NC}"
            ;;
    esac

    echo -e "${CYAN}Syncing files...${NC}"
    rsync $rsync_opts "$local_path" "$remote_path"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Sync completed successfully.${NC}"
    else
        echo -e "${BOLD_RED}Sync failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for rsync remote to local
rsync_remote_to_local() {
    clear
    echo -e "${BOLD_GREEN}Rsync: Remote to Local${NC}"
    echo -e "${CYAN}Enter remote source (user@host:path): ${NC}"
    read remote_path
    echo -e "${CYAN}Enter local destination path: ${NC}"
    read local_path

    if [ -z "$remote_path" ] || [ -z "$local_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select sync options:${NC}"
    echo -e "${GREEN}1. Simple sync (no delete)${NC}"
    echo -e "${GREEN}2. Mirror (with delete)${NC}"
    echo -e "${GREEN}3. Dry run (test only)${NC}"
    read -r sync_option

    local rsync_opts="-avzh --progress"
    case $sync_option in
        1)
            echo -e "${CYAN}Performing simple sync...${NC}"
            ;;
        2)
            echo -e "${YELLOW}Warning: Mirror mode will delete files in destination that don't exist in source${NC}"
            echo -e "${CYAN}Continue? (y/N): ${NC}"
            read -r confirm
            if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
                echo -e "${CYAN}Operation cancelled.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return
            fi
            rsync_opts="$rsync_opts --delete"
            ;;
        3)
            rsync_opts="$rsync_opts --dry-run"
            echo -e "${CYAN}Performing dry run (no actual changes)...${NC}"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using simple sync.${NC}"
            ;;
    esac

    echo -e "${CYAN}Syncing files...${NC}"
    rsync $rsync_opts "$remote_path" "$local_path"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Sync completed successfully.${NC}"
    else
        echo -e "${BOLD_RED}Sync failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for rsync local directory
rsync_local_directory() {
    clear
    echo -e "${BOLD_GREEN}Rsync: Local Directory Sync${NC}"
    echo -e "${CYAN}Enter source directory: ${NC}"
    read source_dir
    echo -e "${CYAN}Enter destination directory: ${NC}"
    read dest_dir

    if [ -z "$source_dir" ] || [ -z "$dest_dir" ]; then
        echo -e "${BOLD_RED}Both directories must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select sync options:${NC}"
    echo -e "${GREEN}1. Simple sync (no delete)${NC}"
    echo -e "${GREEN}2. Mirror (with delete)${NC}"
    echo -e "${GREEN}3. Dry run (test only)${NC}"
    read -r sync_option

    local rsync_opts="-avzh --progress"
    case $sync_option in
        1)
            echo -e "${CYAN}Performing simple sync...${NC}"
            ;;
        2)
            echo -e "${YELLOW}Warning: Mirror mode will delete files in destination that don't exist in source${NC}"
            echo -e "${CYAN}Continue? (y/N): ${NC}"
            read -r confirm
            if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
                echo -e "${CYAN}Operation cancelled.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return
            fi
            rsync_opts="$rsync_opts --delete"
            ;;
        3)
            rsync_opts="$rsync_opts --dry-run"
            echo -e "${CYAN}Performing dry run (no actual changes)...${NC}"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using simple sync.${NC}"
            ;;
    esac

    echo -e "${CYAN}Syncing directories...${NC}"
    rsync $rsync_opts "$source_dir/" "$dest_dir/"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Sync completed successfully.${NC}"
    else
        echo -e "${BOLD_RED}Sync failed. Please check the directories and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for rsync backup with timestamp
rsync_backup_timestamp() {
    clear
    echo -e "${BOLD_GREEN}Rsync: Backup with Timestamp${NC}"
    echo -e "${CYAN}Enter source directory: ${NC}"
    read source_dir
    echo -e "${CYAN}Enter backup destination base directory: ${NC}"
    read backup_base

    if [ -z "$source_dir" ] || [ -z "$backup_base" ]; then
        echo -e "${BOLD_RED}Both directories must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Create timestamp
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="${backup_base}/backup_${timestamp}"

    echo -e "${CYAN}Backup will be created in: ${backup_dir}${NC}"
    echo -e "${CYAN}Continue? (Y/n): ${NC}"
    read -r confirm
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
        echo -e "${CYAN}Operation cancelled.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return
    fi

    # Create backup directory if it doesn't exist
    mkdir -p "$backup_dir"

    echo -e "${CYAN}Creating backup...${NC}"
    rsync -avzh --progress "$source_dir/" "$backup_dir/"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Backup completed successfully.${NC}"
        echo -e "${GREEN}Backup location: ${backup_dir}${NC}"
    else
        echo -e "${BOLD_RED}Backup failed. Please check the directories and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to delete user account
delete_user_only() {
    clear
    echo -e "${BOLD_GREEN}Delete User Account${NC}"
    echo -e "${CYAN}Enter username to delete: ${NC}"
    read username

    if [ -z "$username" ]; then
        echo -e "${BOLD_RED}Username cannot be empty.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Check if user exists
    if ! id "$username" &>/dev/null; then
        echo -e "${BOLD_RED}User '$username' does not exist.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${YELLOW}Are you sure you want to delete user '$username'? (y/N): ${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        sudo userdel "$username"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}User '$username' has been deleted successfully.${NC}"
        else
            echo -e "${BOLD_RED}Failed to delete user '$username'.${NC}"
        fi
    else
        echo -e "${CYAN}Operation cancelled.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to delete user and home directory
delete_user_and_home() {
    clear
    echo -e "${BOLD_GREEN}Delete User and Home Directory${NC}"
    echo -e "${CYAN}Enter username to delete: ${NC}"
    read username

    if [ -z "$username" ]; then
        echo -e "${BOLD_RED}Username cannot be empty.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Check if user exists
    if ! id "$username" &>/dev/null; then
        echo -e "${BOLD_RED}User '$username' does not exist.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${YELLOW}Warning: This will delete the user and their home directory!${NC}"
    echo -e "${YELLOW}Are you sure you want to continue? (y/N): ${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        sudo userdel -r "$username"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}User '$username' and their home directory have been deleted successfully.${NC}"
        else
            echo -e "${BOLD_RED}Failed to delete user '$username' and their home directory.${NC}"
        fi
    else
        echo -e "${CYAN}Operation cancelled.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to delete user and all files
delete_user_and_files() {
    clear
    echo -e "${BOLD_GREEN}Delete User and All Files${NC}"
    echo -e "${CYAN}Enter username to delete: ${NC}"
    read username

    if [ -z "$username" ]; then
        echo -e "${BOLD_RED}Username cannot be empty.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Check if user exists
    if ! id "$username" &>/dev/null; then
        echo -e "${BOLD_RED}User '$username' does not exist.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${YELLOW}Warning: This will delete the user and ALL files owned by them!${NC}"
    echo -e "${YELLOW}Are you sure you want to continue? (y/N): ${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        # Find all files owned by user
        echo -e "${CYAN}Finding all files owned by '$username'...${NC}"
        sudo find / -user "$username" 2>/dev/null

        echo -e "${YELLOW}These are all the files that will be deleted.${NC}"
        echo -e "${YELLOW}Proceed with deletion? (y/N): ${NC}"
        read -r confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            # Delete all files owned by user
            sudo find / -user "$username" -delete 2>/dev/null
            # Delete the user and home directory
            sudo userdel -r "$username"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}User '$username' and all their files have been deleted successfully.${NC}"
            else
                echo -e "${BOLD_RED}Failed to complete the deletion process.${NC}"
            fi
        else
            echo -e "${CYAN}Operation cancelled.${NC}"
        fi
    else
        echo -e "${CYAN}Operation cancelled.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to list all users
list_all_users() {
    clear
    echo -e "${BOLD_GREEN}List All Users${NC}"
    echo -e "${CYAN}System Users:${NC}"
    echo "================================="
    awk -F: '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd
    echo "================================="
    echo -e "${CYAN}Total number of regular users: $(awk -F: '$3 >= 1000 && $3 != 65534 {count++} END {print count}' /etc/passwd)${NC}"

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to display Nginx Management submenu
show_nginx_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         NGINX MANAGEMENT              ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Start Nginx${NC}"
    echo -e "${GREEN}2. Stop Nginx${NC}"
    echo -e "${GREEN}3. Restart Nginx${NC}"
    echo -e "${GREEN}4. Reload Configuration${NC}"
    echo -e "${GREEN}5. Test Configuration${NC}"
    echo -e "${GREEN}6. Show Status${NC}"
    echo -e "${GREEN}7. Show Error Log${NC}"
    echo -e "${GREEN}8. Show Access Log${NC}"
    echo -e "${GREEN}9. Edit Configuration${NC}"
    echo -e "${GREEN}10. List Enabled Sites${NC}"
    echo -e "${GREEN}11. Enable Site${NC}"
    echo -e "${GREEN}12. Disable Site${NC}"
    echo -e "${GREEN}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}Please enter your choice: ${NC}"
}

# Nginx management functions
nginx_start() {
    clear
    echo -e "${BOLD_GREEN}Starting Nginx...${NC}"
    if sudo systemctl start nginx; then
        echo -e "${GREEN}Nginx started successfully.${NC}"
    else
        echo -e "${BOLD_RED}Failed to start Nginx. Check the error log for details.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_stop() {
    clear
    echo -e "${BOLD_GREEN}Stopping Nginx...${NC}"
    if sudo systemctl stop nginx; then
        echo -e "${GREEN}Nginx stopped successfully.${NC}"
    else
        echo -e "${BOLD_RED}Failed to stop Nginx. Check the error log for details.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_restart() {
    clear
    echo -e "${BOLD_GREEN}Restarting Nginx...${NC}"
    if sudo systemctl restart nginx; then
        echo -e "${GREEN}Nginx restarted successfully.${NC}"
    else
        echo -e "${BOLD_RED}Failed to restart Nginx. Check the error log for details.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_reload() {
    clear
    echo -e "${BOLD_GREEN}Reloading Nginx Configuration...${NC}"
    if sudo systemctl reload nginx; then
        echo -e "${GREEN}Nginx configuration reloaded successfully.${NC}"
    else
        echo -e "${BOLD_RED}Failed to reload Nginx configuration. Check the error log for details.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_test_config() {
    clear
    echo -e "${BOLD_GREEN}Testing Nginx Configuration...${NC}"
    if sudo nginx -t; then
        echo -e "${GREEN}Nginx configuration test passed.${NC}"
    else
        echo -e "${BOLD_RED}Nginx configuration test failed.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_status() {
    clear
    echo -e "${BOLD_GREEN}Nginx Status${NC}"
    sudo systemctl status nginx | cat
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_error_log() {
    clear
    echo -e "${BOLD_GREEN}Nginx Error Log${NC}"
    echo -e "${CYAN}Number of lines to show (default: 50): ${NC}"
    read lines
    lines=${lines:-50}

    if [ -f /var/log/nginx/error.log ]; then
        sudo tail -n "$lines" /var/log/nginx/error.log
    else
        echo -e "${BOLD_RED}Error log file not found.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_access_log() {
    clear
    echo -e "${BOLD_GREEN}Nginx Access Log${NC}"
    echo -e "${CYAN}Number of lines to show (default: 50): ${NC}"
    read lines
    lines=${lines:-50}

    if [ -f /var/log/nginx/access.log ]; then
        sudo tail -n "$lines" /var/log/nginx/access.log
    else
        echo -e "${BOLD_RED}Access log file not found.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_edit_config() {
    clear
    echo -e "${BOLD_GREEN}Edit Nginx Configuration${NC}"
    echo -e "${CYAN}Select editor (1. nano, 2. vim): ${NC}"
    read editor_choice

    local editor
    case $editor_choice in
        1) editor="nano" ;;
        2) editor="vim" ;;
        *) editor="nano" ;;
    esac

    if command -v $editor &> /dev/null; then
        sudo $editor /etc/nginx/nginx.conf
    else
        echo -e "${BOLD_RED}Editor $editor not found. Please install it first.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_list_enabled_sites() {
    clear
    echo -e "${BOLD_GREEN}Enabled Nginx Sites${NC}"
    echo -e "${CYAN}Sites in sites-enabled:${NC}"
    echo "================================="
    ls -l /etc/nginx/sites-enabled/
    echo "================================="
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_enable_site() {
    clear
    echo -e "${BOLD_GREEN}Enable Nginx Site${NC}"
    echo -e "${CYAN}Available sites in sites-available:${NC}"
    echo "================================="
    ls -l /etc/nginx/sites-available/
    echo "================================="
    echo -e "${CYAN}Enter site name to enable: ${NC}"
    read site_name

    if [ -z "$site_name" ]; then
        echo -e "${BOLD_RED}Site name cannot be empty.${NC}"
    elif [ -f "/etc/nginx/sites-available/$site_name" ]; then
        if sudo ln -s "/etc/nginx/sites-available/$site_name" "/etc/nginx/sites-enabled/"; then
            echo -e "${GREEN}Site enabled successfully.${NC}"
            echo -e "${CYAN}Testing configuration...${NC}"
            if sudo nginx -t; then
                echo -e "${GREEN}Configuration test passed. Reloading Nginx...${NC}"
                sudo systemctl reload nginx
            else
                echo -e "${BOLD_RED}Configuration test failed. Removing symbolic link...${NC}"
                sudo rm "/etc/nginx/sites-enabled/$site_name"
            fi
        else
            echo -e "${BOLD_RED}Failed to enable site.${NC}"
        fi
    else
        echo -e "${BOLD_RED}Site configuration not found.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

nginx_disable_site() {
    clear
    echo -e "${BOLD_GREEN}Disable Nginx Site${NC}"
    echo -e "${CYAN}Enabled sites:${NC}"
    echo "================================="
    ls -l /etc/nginx/sites-enabled/
    echo "================================="
    echo -e "${CYAN}Enter site name to disable: ${NC}"
    read site_name

    if [ -z "$site_name" ]; then
        echo -e "${BOLD_RED}Site name cannot be empty.${NC}"
    elif [ -L "/etc/nginx/sites-enabled/$site_name" ]; then
        if sudo rm "/etc/nginx/sites-enabled/$site_name"; then
            echo -e "${GREEN}Site disabled successfully.${NC}"
            echo -e "${CYAN}Reloading Nginx...${NC}"
            sudo systemctl reload nginx
        else
            echo -e "${BOLD_RED}Failed to disable site.${NC}"
        fi
    else
        echo -e "${BOLD_RED}Site is not enabled.${NC}"
    fi
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Handle Nginx Management menu options
nginx_management_menu() {
    local choice

    while true; do
        show_nginx_menu
        read choice

        case $choice in
            1) nginx_start ;;
            2) nginx_stop ;;
            3) nginx_restart ;;
            4) nginx_reload ;;
            5) nginx_test_config ;;
            6) nginx_status ;;
            7) nginx_error_log ;;
            8) nginx_access_log ;;
            9) nginx_edit_config ;;
            10) nginx_list_enabled_sites ;;
            11) nginx_enable_site ;;
            12) nginx_disable_site ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
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
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
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
            3) scp_tools ;;
            4) install_homebrew ;;
            5) git_rm_cached_directory ;;
            6) rsync_tools ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
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

# Handle PM2 Management menu options
pm2_management_menu() {
    local choice

    while true; do
        show_pm2_menu
        read choice

        case $choice in
            1) pm2_start_app ;;
            2) pm2_list_apps ;;
            3) pm2_stop_app ;;
            4) pm2_restart_app ;;
            5) pm2_reload_app ;;
            6) pm2_delete_app ;;
            7) pm2_show_logs ;;
            8) pm2_monitor ;;
            9) pm2_setup_startup ;;
            10) pm2_save_process_list ;;
            11) pm2_update ;;
            12) pm2_kill ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Handle YT-DLP menu options
ytdlp_menu() {
    local choice

    while true; do
        show_ytdlp_menu
        read choice

        case $choice in
            1) install_ytdlp ;;
            2) download_single_video ;;
            3) download_playlist ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Handle Delete User menu options
delete_user_menu() {
    local choice

    while true; do
        show_delete_user_menu
        read choice

        case $choice in
            1) delete_user_only ;;
            2) delete_user_and_home ;;
            3) delete_user_and_files ;;
            4) list_all_users ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
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
            4) pm2_management_menu ;;
            5) ytdlp_menu ;;
            6) delete_user_menu ;;
            7) nginx_management_menu ;;
            0) clear ; exit 0 ;;
            *) echo -e "${GREEN}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Start the script
main
