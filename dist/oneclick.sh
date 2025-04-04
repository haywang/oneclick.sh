#!/bin/bash

# Utility functions
# Color definitions
GREEN='\033[0;32m'
BOLD_GREEN='\033[1;32m'
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD_CYAN='\033[1;36m'
NC='\033[0m' # No Color
# Common utility functions

# Display success message
show_success() {
    echo -e "${GREEN}$1${NC}"
}

# Display error message
show_error() {
    echo -e "${BOLD_RED}Error: $1${NC}"
}

# Display info message
show_info() {
    echo -e "${CYAN}$1${NC}"
}

# Display warning message
show_warning() {
    echo -e "${YELLOW}Warning: $1${NC}"
}

# Press any key to continue
press_any_key() {
    echo -e "\n${CYAN}Press any key to continue...${NC}"
    read -n 1 -s -r
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        show_error "This operation requires root privileges."
        return 1
    fi
}

# Confirm action
confirm_action() {
    local message="$1"
    local response

    echo -e "${YELLOW}$message${NC} [y/N] "
    read -r response

    case "$response" in
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Check required dependencies
check_dependencies() {
    local missing_deps=()

    # List of required commands
    local deps=("curl" "wget" "git" "sudo")

    for dep in "${deps[@]}"; do
        if ! command_exists "$dep"; then
            missing_deps+=("$dep")
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${RED}Missing required dependencies: ${missing_deps[*]}${NC}"
        echo -e "${YELLOW}Please install them first.${NC}"
        exit 1
    fi
}
# Input validation functions

# Validate username
validate_username() {
    local username="$1"

    if [[ ! "$username" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        show_error "Invalid username format. Username must start with a letter or underscore and can only contain lowercase letters, numbers, underscores, and hyphens."
        return 1
    fi

    if id "$username" >/dev/null 2>&1; then
        show_error "Username '$username' already exists."
        return 1
    fi

    return 0
}

# Validate port number
validate_port() {
    local port="$1"

    if [[ ! "$port" =~ ^[0-9]+$ ]]; then
        show_error "Port must be a number."
        return 1
    fi

    if [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
        show_error "Port must be between 1 and 65535."
        return 1
    fi

    return 0
}

# Validate IP address
validate_ip() {
    local ip="$1"
    local ip_regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"

    if [[ ! "$ip" =~ $ip_regex ]]; then
        show_error "Invalid IP address format."
        return 1
    fi

    IFS='.' read -r -a ip_parts <<< "$ip"
    for part in "${ip_parts[@]}"; do
        if [ "$part" -lt 0 ] || [ "$part" -gt 255 ]; then
            show_error "IP address parts must be between 0 and 255."
            return 1
        fi
    done

    return 0
}

# Validate URL
validate_url() {
    local url="$1"
    local url_regex="^(https?|ftp)://[^\s/$.?#].[^\s]*$"

    if [[ ! "$url" =~ $url_regex ]]; then
        show_error "Invalid URL format."
        return 1
    fi

    return 0
}

# Validate file path
validate_path() {
    local path="$1"

    if [ ! -e "$path" ]; then
        show_error "Path does not exist: $path"
        return 1
    fi

    return 0
}

# Validate directory path
validate_directory() {
    local dir="$1"

    if [ ! -d "$dir" ]; then
        show_error "Not a directory: $dir"
        return 1
    fi

    return 0
}

# Validate if input is a valid username
is_valid_username() {
    local username=$1
    [[ "$username" =~ ^[a-z_][a-z0-9_-]*[$]?$ ]]
}

# Validate if input is a valid hostname
is_valid_hostname() {
    local hostname=$1
    [[ "$hostname" =~ ^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$ ]]
}

# Validate if input is a valid path
is_valid_path() {
    local path=$1
    [ -e "$path" ]
}
# System management module
# User management functions

# Add a new user
add_new_user() {
    check_root

    local username
    echo -e "${CYAN}Enter username: ${NC}"
    read username

    if ! is_valid_username "$username"; then
        show_error "Invalid username format"
        return 1
    fi

    if id "$username" &>/dev/null; then
        show_error "User $username already exists"
        return 1
    fi

    if confirm_action "Do you want to set a password for $username?"; then
        sudo useradd -m -s /bin/bash "$username"
        sudo passwd "$username"
    else
        sudo useradd -m -s /bin/bash "$username" -p '*'
    fi

    if confirm_action "Do you want to add $username to sudo group?"; then
        sudo usermod -aG sudo "$username"
        show_success "User $username added to sudo group"
    fi

    show_success "User $username created successfully"
}

# Delete user only
delete_user_only() {
    check_root

    local username
    echo -e "${CYAN}Enter username to delete: ${NC}"
    read username

    if ! id "$username" &>/dev/null; then
        show_error "User $username does not exist"
        return 1
    fi

    if confirm_action "Are you sure you want to delete user $username?"; then
        sudo userdel "$username"
        show_success "User $username deleted successfully"
    else
        show_warning "Operation cancelled"
    fi
}

# Delete user and home directory
delete_user_and_home() {
    check_root

    local username
    echo -e "${CYAN}Enter username to delete: ${NC}"
    read username

    if ! id "$username" &>/dev/null; then
        show_error "User $username does not exist"
        return 1
    fi

    if confirm_action "Are you sure you want to delete user $username and their home directory?"; then
        sudo userdel -r "$username"
        show_success "User $username and home directory deleted successfully"
    else
        show_warning "Operation cancelled"
    fi
}

# Delete user and all files
delete_user_and_files() {
    check_root

    local username
    echo -e "${CYAN}Enter username to delete: ${NC}"
    read username

    if ! id "$username" &>/dev/null; then
        show_error "User $username does not exist"
        return 1
    fi

    echo -e "${YELLOW}Files owned by $username:${NC}"
    sudo find / -user "$username" 2>/dev/null

    if confirm_action "Are you sure you want to delete user $username and ALL their files?"; then
        sudo find / -user "$username" -delete 2>/dev/null
        sudo userdel -r "$username"
        show_success "User $username and all their files deleted successfully"
    else
        show_warning "Operation cancelled"
    fi
}

# List all users
list_all_users() {
    echo -e "${CYAN}System Users (UID >= 1000):${NC}"
    awk -F: '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd

    local count
    count=$(awk -F: '$3 >= 1000 && $3 != 65534 {count++} END {print count}' /etc/passwd)
    echo -e "${GREEN}Total users: $count${NC}"

    press_any_key
}
# Software installation module
# Software installation functions

# Install Git
install_git() {
    check_root

    if command_exists git; then
        show_warning "Git is already installed"
        return 0
    fi

    show_success "Installing Git..."
    sudo apt-get update
    sudo apt-get install -y git

    if command_exists git; then
        show_success "Git installed successfully"
        git --version
    else
        show_error "Failed to install Git"
        return 1
    fi

    press_any_key
}

# Install Zsh
install_zsh() {
    check_root

    if command_exists zsh; then
        show_warning "Zsh is already installed"
        return 0
    fi

    show_success "Installing Zsh..."
    sudo apt-get update
    sudo apt-get install -y zsh

    if command_exists zsh; then
        show_success "Zsh installed successfully"
        zsh --version
    else
        show_error "Failed to install Zsh"
        return 1
    fi

    if confirm_action "Do you want to set Zsh as your default shell?"; then
        chsh -s $(which zsh)
        show_success "Zsh set as default shell. Please log out and log back in for changes to take effect."
    fi

    press_any_key
}

# Install Oh-My-Zsh
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        if ! command_exists curl; then
            sudo apt-get update
            sudo apt-get install -y curl
        fi

        show_success "Installing Oh-My-Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

        if [ -d "$HOME/.oh-my-zsh" ]; then
            show_success "Oh-My-Zsh installed successfully"
        else
            show_error "Failed to install Oh-My-Zsh"
            return 1
        fi
    else
        show_warning "Oh-My-Zsh is already installed"
    fi

    press_any_key
}

# Install nvm
install_nvm() {
    if [ ! -d "$HOME/.nvm" ]; then
        if ! command_exists curl; then
            sudo apt-get update
            sudo apt-get install -y curl
        fi

        show_success "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        if command_exists nvm; then
            show_success "nvm installed successfully"
            nvm --version
        else
            show_warning "nvm installed but requires shell restart"
            show_success "Please run 'source ~/.bashrc' or restart your terminal"
        fi
    else
        show_warning "nvm is already installed"
    fi

    press_any_key
}

# Install Node.js
install_node() {
    if ! command_exists nvm; then
        show_error "nvm is not installed. Please install nvm first."
        return 1
    fi

    show_success "Installing latest LTS version of Node.js..."
    nvm install --lts
    nvm use --lts

    if command_exists node; then
        show_success "Node.js installed successfully"
        node --version
    else
        show_error "Failed to install Node.js"
        return 1
    fi

    press_any_key
}

# Install pm2
install_pm2() {
    if ! command_exists npm; then
        show_error "npm is not installed. Please install Node.js first."
        return 1
    fi

    if command_exists pm2; then
        show_warning "pm2 is already installed"
        return 0
    fi

    show_success "Installing pm2..."
    sudo npm install -g pm2

    if command_exists pm2; then
        show_success "pm2 installed successfully"
        pm2 --version
    else
        show_error "Failed to install pm2"
        return 1
    fi

    press_any_key
}

# Install Nginx
install_nginx() {
    check_root

    if command_exists nginx; then
        show_warning "Nginx is already installed"
        return 0
    fi

    show_success "Installing Nginx..."
    sudo apt-get update
    sudo apt-get install -y nginx

    if command_exists nginx; then
        show_success "Nginx installed successfully"
        nginx -v
        sudo systemctl enable nginx
        sudo systemctl start nginx
        show_success "Nginx service enabled and started"
    else
        show_error "Failed to install Nginx"
        return 1
    fi

    press_any_key
}
# Operations management module
# Operations management functions

# PM2 Management Functions
pm2_start_app() {
    local app_path=""

    show_info "Enter the path to your Node.js application:"
    read -r app_path

    if [ ! -f "$app_path" ]; then
        show_error "Application file not found: $app_path"
        return 1
    fi

    show_success "Starting application with PM2..."
    pm2 start "$app_path"

    press_any_key
}

pm2_stop_app() {
    local app_name=""

    show_info "Enter the name/id of the application to stop:"
    read -r app_name

    show_success "Stopping application..."
    pm2 stop "$app_name"

    press_any_key
}

pm2_restart_app() {
    local app_name=""

    show_info "Enter the name/id of the application to restart:"
    read -r app_name

    show_success "Restarting application..."
    pm2 restart "$app_name"

    press_any_key
}

pm2_list_apps() {
    show_success "Listing all PM2 applications..."
    pm2 list

    press_any_key
}

pm2_show_logs() {
    local app_name=""

    show_info "Enter the name/id of the application (leave empty for all):"
    read -r app_name

    if [ -z "$app_name" ]; then
        pm2 logs
    else
        pm2 logs "$app_name"
    fi
}

pm2_monitor() {
    show_success "Starting PM2 monitoring..."
    pm2 monit
}

# Nginx Management Functions
nginx_start() {
    check_root

    show_success "Starting Nginx..."
    sudo systemctl start nginx

    if systemctl is-active --quiet nginx; then
        show_success "Nginx started successfully"
    else
        show_error "Failed to start Nginx"
        return 1
    fi

    press_any_key
}

nginx_stop() {
    check_root

    show_success "Stopping Nginx..."
    sudo systemctl stop nginx

    if ! systemctl is-active --quiet nginx; then
        show_success "Nginx stopped successfully"
    else
        show_error "Failed to stop Nginx"
        return 1
    fi

    press_any_key
}

nginx_restart() {
    check_root

    show_success "Restarting Nginx..."
    sudo systemctl restart nginx

    if systemctl is-active --quiet nginx; then
        show_success "Nginx restarted successfully"
    else
        show_error "Failed to restart Nginx"
        return 1
    fi

    press_any_key
}

nginx_reload() {
    check_root

    show_success "Reloading Nginx configuration..."
    sudo systemctl reload nginx

    if [ $? -eq 0 ]; then
        show_success "Nginx configuration reloaded successfully"
    else
        show_error "Failed to reload Nginx configuration"
        return 1
    fi

    press_any_key
}

nginx_test_config() {
    check_root

    show_success "Testing Nginx configuration..."
    sudo nginx -t

    press_any_key
}

nginx_show_status() {
    check_root

    show_success "Nginx status:"
    sudo systemctl status nginx

    press_any_key
}

nginx_edit_config() {
    check_root

    local editor=${EDITOR:-nano}
    show_success "Opening Nginx configuration in $editor..."
    sudo $editor /etc/nginx/nginx.conf

    if confirm_action "Would you like to test the configuration?"; then
        nginx_test_config
    fi

    press_any_key
}

nginx_list_sites() {
    check_root

    show_success "Available sites:"
    ls -l /etc/nginx/sites-available/

    show_success "\nEnabled sites:"
    ls -l /etc/nginx/sites-enabled/

    press_any_key
}

nginx_enable_site() {
    check_root

    local site_name=""

    show_info "Enter the site configuration name:"
    read -r site_name

    if [ ! -f "/etc/nginx/sites-available/$site_name" ]; then
        show_error "Site configuration not found: $site_name"
        return 1
    fi

    show_success "Enabling site $site_name..."
    sudo ln -s "/etc/nginx/sites-available/$site_name" "/etc/nginx/sites-enabled/"

    if [ $? -eq 0 ]; then
        show_success "Site enabled successfully"
        if confirm_action "Would you like to test the configuration?"; then
            nginx_test_config
        fi
        if confirm_action "Would you like to reload Nginx?"; then
            nginx_reload
        fi
    else
        show_error "Failed to enable site"
        return 1
    fi

    press_any_key
}

nginx_disable_site() {
    check_root

    local site_name=""

    show_info "Enter the site configuration name:"
    read -r site_name

    if [ ! -L "/etc/nginx/sites-enabled/$site_name" ]; then
        show_error "Site is not enabled: $site_name"
        return 1
    fi

    show_success "Disabling site $site_name..."
    sudo rm "/etc/nginx/sites-enabled/$site_name"

    if [ $? -eq 0 ]; then
        show_success "Site disabled successfully"
        if confirm_action "Would you like to reload Nginx?"; then
            nginx_reload
        fi
    else
        show_error "Failed to disable site"
        return 1
    fi

    press_any_key
}
# File transfer module
# File transfer functions

# SCP file transfer
scp_transfer() {
    local source_path=""
    local dest_path=""
    local direction=""
    local remote_host=""
    local remote_user=""

    show_info "Select transfer direction:"
    echo "1) Upload (Local -> Remote)"
    echo "2) Download (Remote -> Local)"
    read -r direction

    case $direction in
        1)
            show_info "Enter local source file/directory path:"
            read -r source_path

            show_info "Enter remote username:"
            read -r remote_user

            show_info "Enter remote host:"
            read -r remote_host

            show_info "Enter remote destination path:"
            read -r dest_path

            if [ ! -e "$source_path" ]; then
                show_error "Source path does not exist: $source_path"
                return 1
            fi

            show_success "Uploading to remote server..."
            if [ -d "$source_path" ]; then
                scp -r "$source_path" "$remote_user@$remote_host:$dest_path"
            else
                scp "$source_path" "$remote_user@$remote_host:$dest_path"
            fi
            ;;

        2)
            show_info "Enter remote username:"
            read -r remote_user

            show_info "Enter remote host:"
            read -r remote_host

            show_info "Enter remote source file/directory path:"
            read -r source_path

            show_info "Enter local destination path:"
            read -r dest_path

            if [ ! -d "$(dirname "$dest_path")" ]; then
                show_error "Destination directory does not exist: $(dirname "$dest_path")"
                return 1
            fi

            show_success "Downloading from remote server..."
            scp -r "$remote_user@$remote_host:$source_path" "$dest_path"
            ;;

        *)
            show_error "Invalid option"
            return 1
            ;;
    esac

    if [ $? -eq 0 ]; then
        show_success "Transfer completed successfully"
    else
        show_error "Transfer failed"
        return 1
    fi

    press_any_key
}

# Rsync synchronization
rsync_sync() {
    local source_path=""
    local dest_path=""
    local direction=""
    local remote_host=""
    local remote_user=""
    local options=""

    show_info "Select sync direction:"
    echo "1) Upload (Local -> Remote)"
    echo "2) Download (Remote -> Local)"
    read -r direction

    show_info "Select sync options:"
    echo "1) Mirror (delete files that don't exist in source)"
    echo "2) Update (only newer files)"
    echo "3) Backup (keep old files)"
    read -r options

    case $options in
        1) options="-avz --delete" ;;
        2) options="-avz --update" ;;
        3) options="-avz --backup" ;;
        *) options="-avz" ;;
    esac

    case $direction in
        1)
            show_info "Enter local source directory path:"
            read -r source_path

            show_info "Enter remote username:"
            read -r remote_user

            show_info "Enter remote host:"
            read -r remote_host

            show_info "Enter remote destination path:"
            read -r dest_path

            if [ ! -d "$source_path" ]; then
                show_error "Source directory does not exist: $source_path"
                return 1
            fi

            show_success "Syncing to remote server..."
            rsync $options "$source_path/" "$remote_user@$remote_host:$dest_path"
            ;;

        2)
            show_info "Enter remote username:"
            read -r remote_user

            show_info "Enter remote host:"
            read -r remote_host

            show_info "Enter remote source directory path:"
            read -r source_path

            show_info "Enter local destination path:"
            read -r dest_path

            if [ ! -d "$dest_path" ]; then
                show_error "Destination directory does not exist: $dest_path"
                return 1
            fi

            show_success "Syncing from remote server..."
            rsync $options "$remote_user@$remote_host:$source_path/" "$dest_path"
            ;;

        *)
            show_error "Invalid option"
            return 1
            ;;
    esac

    if [ $? -eq 0 ]; then
        show_success "Synchronization completed successfully"
    else
        show_error "Synchronization failed"
        return 1
    fi

    press_any_key
}

# SSH key management
generate_ssh_key() {
    local key_type=""
    local key_name=""
    local key_comment=""

    show_info "Select SSH key type:"
    echo "1) RSA (default)"
    echo "2) Ed25519 (more secure)"
    read -r key_type

    show_info "Enter key name (default: id_rsa or id_ed25519):"
    read -r key_name

    show_info "Enter key comment (usually your email):"
    read -r key_comment

    case $key_type in
        2)
            if [ -z "$key_name" ]; then
                key_name="id_ed25519"
            fi
            ssh-keygen -t ed25519 -f "$HOME/.ssh/$key_name" -C "$key_comment"
            ;;
        *)
            if [ -z "$key_name" ]; then
                key_name="id_rsa"
            fi
            ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/$key_name" -C "$key_comment"
            ;;
    esac

    if [ $? -eq 0 ]; then
        show_success "SSH key generated successfully"
        show_info "Your public key is:"
        cat "$HOME/.ssh/$key_name.pub"
    else
        show_error "Failed to generate SSH key"
        return 1
    fi

    press_any_key
}

# Copy SSH key to remote server
copy_ssh_key() {
    local remote_user=""
    local remote_host=""
    local key_path=""

    show_info "Enter remote username:"
    read -r remote_user

    show_info "Enter remote host:"
    read -r remote_host

    show_info "Enter path to public key (default: ~/.ssh/id_rsa.pub):"
    read -r key_path

    if [ -z "$key_path" ]; then
        key_path="$HOME/.ssh/id_rsa.pub"
    fi

    if [ ! -f "$key_path" ]; then
        show_error "Public key file not found: $key_path"
        return 1
    fi

    show_success "Copying SSH key to remote server..."
    ssh-copy-id -i "$key_path" "$remote_user@$remote_host"

    if [ $? -eq 0 ]; then
        show_success "SSH key copied successfully"
    else
        show_error "Failed to copy SSH key"
        return 1
    fi

    press_any_key
}
# Git operations module
 
# Video download module
# Video download functions

# Install or update yt-dlp
install_ytdlp() {
    if ! command_exists yt-dlp; then
        show_success "Installing yt-dlp..."
        if command_exists pip3; then
            pip3 install --upgrade yt-dlp
        else
            show_error "pip3 is not installed. Please install Python3 and pip3 first."
            return 1
        fi
    else
        show_success "Updating yt-dlp..."
        pip3 install --upgrade yt-dlp
    fi

    if command_exists yt-dlp; then
        show_success "yt-dlp installed/updated successfully"
        yt-dlp --version
    else
        show_error "Failed to install/update yt-dlp"
        return 1
    fi

    press_any_key
}

# Download single video
download_single_video() {
    local video_url=""
    local quality=""
    local format=""

    show_info "Enter video URL:"
    read -r video_url

    show_info "Select video quality:"
    echo "1) Best quality"
    echo "2) 1080p"
    echo "3) 720p"
    echo "4) 480p"
    echo "5) Audio only"
    read -r quality

    case $quality in
        1) format="bestvideo+bestaudio/best" ;;
        2) format="bestvideo[height<=1080]+bestaudio/best[height<=1080]" ;;
        3) format="bestvideo[height<=720]+bestaudio/best[height<=720]" ;;
        4) format="bestvideo[height<=480]+bestaudio/best[height<=480]" ;;
        5) format="bestaudio[ext=m4a]/bestaudio" ;;
        *) format="bestvideo+bestaudio/best" ;;
    esac

    show_success "Downloading video..."
    yt-dlp -f "$format" "$video_url"

    press_any_key
}

# Download playlist
download_playlist() {
    local playlist_url=""
    local quality=""
    local format=""
    local start_index=""
    local end_index=""

    show_info "Enter playlist URL:"
    read -r playlist_url

    show_info "Select video quality:"
    echo "1) Best quality"
    echo "2) 1080p"
    echo "3) 720p"
    echo "4) 480p"
    echo "5) Audio only"
    read -r quality

    case $quality in
        1) format="bestvideo+bestaudio/best" ;;
        2) format="bestvideo[height<=1080]+bestaudio/best[height<=1080]" ;;
        3) format="bestvideo[height<=720]+bestaudio/best[height<=720]" ;;
        4) format="bestvideo[height<=480]+bestaudio/best[height<=480]" ;;
        5) format="bestaudio[ext=m4a]/bestaudio" ;;
        *) format="bestvideo+bestaudio/best" ;;
    esac

    show_info "Enter start index (leave empty for beginning):"
    read -r start_index

    show_info "Enter end index (leave empty for end):"
    read -r end_index

    local range_opt=""
    if [ -n "$start_index" ] && [ -n "$end_index" ]; then
        range_opt="--playlist-start $start_index --playlist-end $end_index"
    elif [ -n "$start_index" ]; then
        range_opt="--playlist-start $start_index"
    elif [ -n "$end_index" ]; then
        range_opt="--playlist-end $end_index"
    fi

    show_success "Downloading playlist..."
    yt-dlp -f "$format" $range_opt "$playlist_url"

    press_any_key
}
# Menu modules
# System management menu functions

# Display system management menu
show_system_menu() {
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
        show_system_menu
        read choice

        case $choice in
            1) delete_user_menu ;;  # 用户管理子菜单
            2) check_port_usage ;;  # 端口管理
            3) ufw_management_menu ;;  # UFW防火墙管理
            4) top_command ;;  # 系统监控
            0) break ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
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
    echo -e "${GREEN}1. Delete User Only${NC}"
    echo -e "${GREEN}2. Delete User and Home Directory${NC}"
    echo -e "${GREEN}3. Delete User and All Files${NC}"
    echo -e "${GREEN}4. List All Users${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle user management menu choices
delete_user_menu() {
    local choice

    while true; do
        show_user_management_menu
        read choice

        case $choice in
            1) delete_user_only ;;
            2) delete_user_and_home ;;
            3) delete_user_and_files ;;
            4) list_all_users ;;
            0) break ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}

# System monitoring function
top_command() {
    show_success "Starting system monitor..."
    top
}

# System monitoring functions
system_monitor() {
    show_success "System monitoring with top..."
    top
    press_any_key
}

disk_usage() {
    show_success "Disk usage information:"
    df -h
    echo -e "\nDetailed disk usage for home directory:"
    du -h --max-depth=1 ~
    press_any_key
}

memory_usage() {
    show_success "Memory usage information:"
    free -h
    echo -e "\nDetailed memory information:"
    cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable|SwapTotal|SwapFree"
    press_any_key
}

process_management() {
    show_success "Running processes (sorted by CPU usage):"
    ps aux --sort=-%cpu | head -n 11
    press_any_key
}

# Port management menu
show_port_management_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         PORT MANAGEMENT              ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Check Port Usage${NC}"
    echo -e "${GREEN}2. List All Listening Ports${NC}"
    echo -e "${GREEN}3. Check Specific Port${NC}"
    echo -e "${YELLOW}0. Back to system menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle port management menu choices
port_management_menu() {
    local choice

    while true; do
        show_port_management_menu
        read choice

        case $choice in
            1) check_port_usage ;;
            2) list_listening_ports ;;
            3) check_specific_port ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Port management functions
check_port_usage() {
    show_success "Current port usage:"
    netstat -tulpn | grep LISTEN
    press_any_key
}

list_listening_ports() {
    show_success "All listening ports:"
    ss -tulwn
    press_any_key
}

check_specific_port() {
    local port
    show_info "Enter port number to check:"
    read -r port

    if [[ ! "$port" =~ ^[0-9]+$ ]]; then
        show_error "Invalid port number"
        return 1
    fi

    show_success "Checking port $port..."
    lsof -i :$port
    press_any_key
}
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
# Operations management menu functions

# Display PM2 management menu
show_pm2_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         PM2 MANAGEMENT               ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Start application${NC}"
    echo -e "${GREEN}2. Stop application${NC}"
    echo -e "${GREEN}3. Restart application${NC}"
    echo -e "${GREEN}4. List applications${NC}"
    echo -e "${GREEN}5. Show logs${NC}"
    echo -e "${GREEN}6. Monitor applications${NC}"
    echo -e "${YELLOW}0. Back to operations menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle PM2 management menu choices
pm2_management_menu() {
    local choice

    while true; do
        show_pm2_menu
        read choice

        case $choice in
            1) pm2_start_app ;;
            2) pm2_stop_app ;;
            3) pm2_restart_app ;;
            4) pm2_list_apps ;;
            5) pm2_show_logs ;;
            6) pm2_monitor ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Display Nginx management menu
show_nginx_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         NGINX MANAGEMENT             ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Start Nginx${NC}"
    echo -e "${GREEN}2. Stop Nginx${NC}"
    echo -e "${GREEN}3. Restart Nginx${NC}"
    echo -e "${GREEN}4. Reload configuration${NC}"
    echo -e "${GREEN}5. Test configuration${NC}"
    echo -e "${GREEN}6. Show status${NC}"
    echo -e "${GREEN}7. Edit configuration${NC}"
    echo -e "${GREEN}8. List sites${NC}"
    echo -e "${GREEN}9. Enable site${NC}"
    echo -e "${GREEN}10. Disable site${NC}"
    echo -e "${YELLOW}0. Back to operations menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle Nginx management menu choices
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
            6) nginx_show_status ;;
            7) nginx_edit_config ;;
            8) nginx_list_sites ;;
            9) nginx_enable_site ;;
            10) nginx_disable_site ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Display operations management menu
show_ops_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}      OPERATIONS MANAGEMENT          ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. PM2 Management${NC}"
    echo -e "${GREEN}2. Nginx Management${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle operations management menu choices
ops_management_menu() {
    local choice

    while true; do
        show_ops_menu
        read choice

        case $choice in
            1) pm2_management_menu ;;
            2) nginx_management_menu ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}
# File transfer menu functions

# Display file transfer menu
show_file_transfer_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         FILE TRANSFER                ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. SCP Transfer${NC}"
    echo -e "${GREEN}2. Rsync Synchronization${NC}"
    echo -e "${GREEN}3. Generate SSH Key${NC}"
    echo -e "${GREEN}4. Copy SSH Key to Server${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle file transfer menu choices
file_transfer_menu() {
    local choice

    while true; do
        show_file_transfer_menu
        read choice

        case $choice in
            1) scp_transfer ;;
            2) rsync_sync ;;
            3) generate_ssh_key ;;
            4) copy_ssh_key ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}
# Git operations menu functions

# Display Git operations menu
show_git_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         GIT OPERATIONS MENU          ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Clean Git Cache${NC}"
    echo -e "${GREEN}2. Show Git Status${NC}"
    echo -e "${GREEN}3. Add All Changes${NC}"
    echo -e "${GREEN}4. Commit Changes${NC}"
    echo -e "${GREEN}5. Push to Remote${NC}"
    echo -e "${GREEN}6. Pull from Remote${NC}"
    echo -e "${GREEN}7. Show Git Log${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle Git operations menu choices
git_operations_menu() {
    local choice

    while true; do
        show_git_menu
        read choice

        case $choice in
            1) clean_git_cache ;;
            2) show_git_status ;;
            3) git_add_all ;;
            4) git_commit ;;
            5) git_push ;;
            6) git_pull ;;
            7) show_git_log ;;
            0) break ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}
# Video download menu functions

# Display video download menu
show_video_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         VIDEO DOWNLOAD MENU          ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Download Single Video${NC}"
    echo -e "${GREEN}2. Download Playlist${NC}"
    echo -e "${GREEN}3. Download Video (Best Quality)${NC}"
    echo -e "${GREEN}4. Download Audio Only${NC}"
    echo -e "${GREEN}5. Show Available Formats${NC}"
    echo -e "${GREEN}6. Download Custom Format${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle video download menu choices
video_download_menu() {
    local choice

    while true; do
        show_video_menu
        read choice

        case $choice in
            1) download_single_video ;;
            2) download_playlist ;;
            3) download_best_quality ;;
            4) download_audio ;;
            5) show_formats ;;
            6) download_custom_format ;;
            0) break ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}
# Main menu functions

# Display main menu
show_main_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         SYSTEM MANAGEMENT            ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. System Management${NC}"
    echo -e "${GREEN}2. Software Installation${NC}"
    echo -e "${GREEN}3. Operations Management${NC}"
    echo -e "${GREEN}4. File Transfer${NC}"
    echo -e "${GREEN}5. Git Operations${NC}"
    echo -e "${GREEN}6. Video Download${NC}"
    echo -e "${GREEN}7. Quick Install Common Tools${NC}"
    echo -e "${YELLOW}0. Exit${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Quick install common tools
install_common_tools() {
    show_success "Installing common tools..."

    # Update package list
    sudo apt-get update

    # Install common development tools
    sudo apt-get install -y build-essential git curl wget

    # Install system tools
    sudo apt-get install -y htop net-tools tree

    # Install text editors
    sudo apt-get install -y vim nano

    show_success "Common tools installed successfully"
    press_any_key
}

# Handle main menu choices
main_menu() {
    local choice

    while true; do
        show_main_menu
        read choice

        case $choice in
            1) system_management_menu ;;
            2) software_installation_menu ;;
            3) ops_management_menu ;;
            4) file_transfer_menu ;;
            5) git_operations_menu ;;
            6) video_download_menu ;;
            7) install_common_tools ;;
            0)
                echo -e "${GREEN}Thank you for using the system management tool!${NC}"
                exit 0
                ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}
# Start the application
main_menu
