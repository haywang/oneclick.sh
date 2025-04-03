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
    echo -e "${GREEN}5. Install Homebrew${NC}"
    echo -e "${GREEN}6. Git Remove Cached Directory${NC}"
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
    }

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
    }

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
            3) scp_local_to_server ;;
            4) scp_server_to_local ;;
            5) install_homebrew ;;
            6) git_rm_cached_directory ;;
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
            0) clear ; exit 0 ;;
            *) echo -e "${GREEN}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Start the script
main
