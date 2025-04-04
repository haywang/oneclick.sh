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