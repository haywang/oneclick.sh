# Software installation functions

# Check if Homebrew is installed (macOS only)
check_homebrew() {
    if ! command_exists brew; then
        show_error "Homebrew is not installed. Please install it first."
        show_info "You can install Homebrew with: /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        press_any_key
        return 1
    fi
    return 0
}

# Ensure curl is installed
ensure_curl_installed() {
    if ! command_exists curl; then
        show_warning "curl is required but not installed. Attempting to install..."

        if [[ "$(uname -s)" == "Darwin" ]]; then
            check_homebrew || return 1
            brew install curl
        else
            sudo apt-get update
            sudo apt-get install -y curl
        fi

        if ! command_exists curl; then
            show_error "Failed to install curl."
            press_any_key
            return 1
        fi
    fi
    return 0
}

# Load NVM if it exists
load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        . "$NVM_DIR/nvm.sh"
        return 0
    else
        show_error "nvm is not properly installed. NVM_DIR=$NVM_DIR"
        show_error "nvm.sh not found."
        return 1
    fi
}

# Common start for software installation
start_install() {
    local software_name="$1"
    local batch_mode="$2"

    if [ "$batch_mode" != "true" ]; then
        clear
    fi
    show_success "Installing $software_name..."
    echo "Current system: $(uname -s)"
}

# Check if software already installed
check_already_installed() {
    local cmd="$1"
    local name="$2"
    local batch_mode="$3"

    if command_exists "$cmd"; then
        show_warning "$name is already installed"
        "$cmd" --version 2>/dev/null || true
        if [ "$batch_mode" != "true" ]; then
            press_any_key
        fi
        return 0
    fi
    return 1
}

# Common install based on OS
install_package() {
    local package="$1"
    local cmd="$2"

    # Detect OS
    if [[ "$(uname -s)" == "Darwin" ]]; then
        # macOS
        check_homebrew || return 1
        show_success "Installing $package using Homebrew..."
        brew install "$package"
    else
        # Linux
        check_root
        show_success "Installing $package using apt..."
        sudo apt-get update
        sudo apt-get install -y "$package"
    fi

    if command_exists "$cmd"; then
        show_success "$package installed successfully"
        "$cmd" --version 2>/dev/null || true
        return 0
    else
        show_error "Failed to install $package"
        return 1
    fi
}

# Install Git
install_git() {
    local batch_mode="$1"

    start_install "Git" "$batch_mode"
    check_already_installed "git" "Git" "$batch_mode" && return 0
    install_package "git" "git"
    if [ "$batch_mode" != "true" ]; then
        press_any_key
    fi
}

# Install Zsh
install_zsh() {
    local batch_mode="$1"

    start_install "Zsh" "$batch_mode"

    if check_already_installed "zsh" "Zsh" "$batch_mode"; then
        return 0
    fi

    install_package "zsh" "zsh" || return 1

    if [ "$batch_mode" != "true" ]; then
        if confirm_action "Do you want to set Zsh as your default shell?"; then
            chsh -s $(which zsh)
            show_success "Zsh set as default shell. Please log out and log back in for changes to take effect."
        fi
        press_any_key
    else
        show_info "Run 'chsh -s $(which zsh)' to set Zsh as your default shell"
    fi
}

# Install Oh-My-Zsh
install_oh_my_zsh() {
    local batch_mode="$1"

    start_install "Oh-My-Zsh" "$batch_mode"

    if [ -d "$HOME/.oh-my-zsh" ]; then
        show_warning "Oh-My-Zsh is already installed"
        if [ "$batch_mode" != "true" ]; then
            press_any_key
        fi
        return 0
    fi

    ensure_curl_installed || return 1

    show_success "Downloading and installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    if [ -d "$HOME/.oh-my-zsh" ]; then
        show_success "Oh-My-Zsh installed successfully"
    else
        show_error "Failed to install Oh-My-Zsh"
    fi

    if [ "$batch_mode" != "true" ]; then
        press_any_key
    fi
}

# Install nvm
install_nvm() {
    local batch_mode="$1"

    start_install "nvm" "$batch_mode"

    if [ -d "$HOME/.nvm" ]; then
        show_warning "nvm is already installed"

        # Try to load nvm
        if load_nvm; then
            show_success "nvm loaded successfully"
            nvm --version 2>/dev/null || echo "Could not execute nvm command"
        fi

        if [ "$batch_mode" != "true" ]; then
            press_any_key
        fi
        return 0
    fi

    ensure_curl_installed || return 1

    show_success "Downloading and installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

    # Try to load nvm immediately
    if load_nvm; then
        show_success "nvm installed and loaded successfully"
        nvm --version
    else
        show_warning "nvm installed but requires shell restart"
        show_info "Please run 'source ~/.bashrc' or restart your terminal"
        show_info "NVM_DIR is set to: $NVM_DIR"
        if [ -f "$NVM_DIR/nvm.sh" ]; then
            show_success "nvm.sh file exists"
        else
            show_error "nvm.sh file not found in $NVM_DIR"
        fi
    fi

    if [ "$batch_mode" != "true" ]; then
        press_any_key
    fi
}

# Install Node.js
install_node() {
    local batch_mode="$1"

    start_install "Node.js" "$batch_mode"

    # Try to load nvm
    if ! load_nvm; then
        show_error "Please install nvm first."
        if [ "$batch_mode" != "true" ]; then
            press_any_key
        fi
        return 1
    fi

    if ! type nvm >/dev/null 2>&1; then
        show_error "nvm command not available. Please install nvm first and restart your terminal."
        if [ "$batch_mode" != "true" ]; then
            press_any_key
        fi
        return 1
    fi

    show_success "Installing latest LTS version of Node.js using nvm..."
    nvm install --lts
    nvm use --lts

    if command_exists node; then
        show_success "Node.js installed successfully"
        node --version
        npm --version
    else
        show_error "Failed to install Node.js"
        show_info "You may need to restart your terminal or run 'source ~/.bashrc'"
    fi

    if [ "$batch_mode" != "true" ]; then
        press_any_key
    fi
}

# Install pm2
install_pm2() {
    local batch_mode="$1"

    start_install "pm2" "$batch_mode"

    if check_already_installed "pm2" "pm2" "$batch_mode"; then
        return 0
    fi

    # Try to load nvm and node
    load_nvm

    if ! command_exists npm; then
        show_error "npm is not installed or not in PATH"
        show_info "Current PATH: $PATH"
        show_info "Please install Node.js first and restart your terminal"
        if [ "$batch_mode" != "true" ]; then
            press_any_key
        fi
        return 1
    fi

    show_success "Installing pm2 using npm..."
    npm install -g pm2

    if command_exists pm2; then
        show_success "pm2 installed successfully"
        pm2 --version
    else
        show_error "Failed to install pm2"
        show_info "You may need to use sudo: sudo npm install -g pm2"
    fi

    if [ "$batch_mode" != "true" ]; then
        press_any_key
    fi
}

# Install Nginx
install_nginx() {
    local batch_mode="$1"

    start_install "Nginx" "$batch_mode"

    if check_already_installed "nginx" "Nginx" "$batch_mode"; then
        return 0
    fi

    # Detect OS
    if [[ "$(uname -s)" == "Darwin" ]]; then
        # macOS
        check_homebrew || return 1

        show_success "Installing Nginx using Homebrew..."
        brew install nginx

        if command_exists nginx; then
            show_success "Nginx installed successfully"
            nginx -v
            show_success "To start Nginx: brew services start nginx"
            show_success "To stop Nginx: brew services stop nginx"
        else
            show_error "Failed to install Nginx"
        fi
    else
        # Linux
        check_root
        show_success "Installing Nginx using apt..."
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
        fi
    fi

    if [ "$batch_mode" != "true" ]; then
        press_any_key
    fi
}

# Batch install all tools
install_all_tools() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}      BATCH INSTALLING ALL TOOLS       ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"

    show_info "The following tools will be installed in sequence:"
    echo -e "  ${CYAN}1. Git${NC}"
    echo -e "  ${CYAN}2. Zsh${NC}"
    echo -e "  ${CYAN}3. Oh-My-Zsh${NC}"
    echo -e "  ${CYAN}4. nvm${NC}"
    echo -e "  ${CYAN}5. Node.js${NC}"
    echo -e "  ${CYAN}6. pm2${NC}"
    echo -e "  ${CYAN}7. Nginx${NC}"
    echo ""

    # Pass 'true' as the batch_mode parameter to all install functions
    install_git "true"
    install_zsh "true"
    install_oh_my_zsh "true"
    install_nvm "true"
    install_node "true"
    install_pm2 "true"
    install_nginx "true"

    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}      ALL TOOLS INSTALLED              ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    press_any_key
}