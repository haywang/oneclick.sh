# Operations management functions

# PM2 Management Functions

# Start a PM2 application
pm2_start_app() {
    echo -e "${CYAN}Enter the application name or path: ${NC}"
    read -r app_path

    if [ -z "$app_path" ]; then
        show_error "Application path cannot be empty."
        return 1
    fi

    if ! command -v pm2 &> /dev/null; then
        show_error "PM2 is not installed. Please install it first."
        return 1
    }

    echo -e "${YELLOW}Starting application: $app_path${NC}"
    pm2 start "$app_path"
    show_success "Application started successfully."
    press_any_key
}

# Stop a PM2 application
pm2_stop_app() {
    if ! command -v pm2 &> /dev/null; then
        show_error "PM2 is not installed. Please install it first."
        return 1
    }

    echo -e "${CYAN}Current PM2 processes:${NC}"
    pm2 list

    echo -e "${CYAN}Enter the application name or id to stop: ${NC}"
    read -r app_name

    if [ -z "$app_name" ]; then
        show_error "Application name cannot be empty."
        return 1
    fi

    echo -e "${YELLOW}Stopping application: $app_name${NC}"
    pm2 stop "$app_name"
    show_success "Application stopped successfully."
    press_any_key
}

# Restart a PM2 application
pm2_restart_app() {
    if ! command -v pm2 &> /dev/null; then
        show_error "PM2 is not installed. Please install it first."
        return 1
    }

    echo -e "${CYAN}Current PM2 processes:${NC}"
    pm2 list

    echo -e "${CYAN}Enter the application name or id to restart: ${NC}"
    read -r app_name

    if [ -z "$app_name" ]; then
        show_error "Application name cannot be empty."
        return 1
    fi

    echo -e "${YELLOW}Restarting application: $app_name${NC}"
    pm2 restart "$app_name"
    show_success "Application restarted successfully."
    press_any_key
}

# List PM2 applications
pm2_list_apps() {
    if ! command -v pm2 &> /dev/null; then
        show_error "PM2 is not installed. Please install it first."
        return 1
    }

    echo -e "${CYAN}Current PM2 processes:${NC}"
    pm2 list
    press_any_key
}

# Show PM2 logs
pm2_show_logs() {
    if ! command -v pm2 &> /dev/null; then
        show_error "PM2 is not installed. Please install it first."
        return 1
    }

    echo -e "${CYAN}Current PM2 processes:${NC}"
    pm2 list

    echo -e "${CYAN}Enter the application name to show logs (press Enter for all logs): ${NC}"
    read -r app_name

    if [ -z "$app_name" ]; then
        pm2 logs | cat
    else
        pm2 logs "$app_name" | cat
    fi
}

# Monitor PM2 applications
pm2_monitor() {
    if ! command -v pm2 &> /dev/null; then
        show_error "PM2 is not installed. Please install it first."
        return 1
    }

    echo -e "${YELLOW}Starting PM2 monitoring...${NC}"
    pm2 monit | cat
}

# Nginx Management Functions

# Start Nginx
nginx_start() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    echo -e "${YELLOW}Starting Nginx...${NC}"
    sudo systemctl start nginx
    show_success "Nginx started successfully."
    press_any_key
}

# Stop Nginx
nginx_stop() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    echo -e "${YELLOW}Stopping Nginx...${NC}"
    sudo systemctl stop nginx
    show_success "Nginx stopped successfully."
    press_any_key
}

# Restart Nginx
nginx_restart() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    echo -e "${YELLOW}Restarting Nginx...${NC}"
    sudo systemctl restart nginx
    show_success "Nginx restarted successfully."
    press_any_key
}

# Reload Nginx configuration
nginx_reload() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    echo -e "${YELLOW}Reloading Nginx configuration...${NC}"
    sudo systemctl reload nginx
    show_success "Nginx configuration reloaded successfully."
    press_any_key
}

# Test Nginx configuration
nginx_test_config() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    echo -e "${YELLOW}Testing Nginx configuration...${NC}"
    sudo nginx -t
    press_any_key
}

# Show Nginx status
nginx_show_status() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    echo -e "${YELLOW}Nginx status:${NC}"
    sudo systemctl status nginx | cat
    press_any_key
}

# Edit Nginx configuration
nginx_edit_config() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    local editor
    if [ -n "$EDITOR" ]; then
        editor="$EDITOR"
    else
        editor="nano"
    fi

    echo -e "${YELLOW}Opening Nginx configuration in $editor...${NC}"
    sudo $editor /etc/nginx/nginx.conf
}

# List Nginx sites
nginx_list_sites() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    echo -e "${CYAN}Available sites:${NC}"
    ls -l /etc/nginx/sites-available/
    echo -e "\n${CYAN}Enabled sites:${NC}"
    ls -l /etc/nginx/sites-enabled/
    press_any_key
}

# Enable Nginx site
nginx_enable_site() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    echo -e "${CYAN}Available sites:${NC}"
    ls -l /etc/nginx/sites-available/

    echo -e "${CYAN}Enter the site name to enable: ${NC}"
    read -r site_name

    if [ -z "$site_name" ]; then
        show_error "Site name cannot be empty."
        return 1
    fi

    if [ ! -f "/etc/nginx/sites-available/$site_name" ]; then
        show_error "Site configuration not found."
        return 1
    fi

    echo -e "${YELLOW}Enabling site: $site_name${NC}"
    sudo ln -s "/etc/nginx/sites-available/$site_name" "/etc/nginx/sites-enabled/"
    sudo nginx -t && sudo systemctl reload nginx
    show_success "Site enabled successfully."
    press_any_key
}

# Disable Nginx site
nginx_disable_site() {
    if ! command -v nginx &> /dev/null; then
        show_error "Nginx is not installed. Please install it first."
        return 1
    }

    echo -e "${CYAN}Enabled sites:${NC}"
    ls -l /etc/nginx/sites-enabled/

    echo -e "${CYAN}Enter the site name to disable: ${NC}"
    read -r site_name

    if [ -z "$site_name" ]; then
        show_error "Site name cannot be empty."
        return 1
    fi

    if [ ! -f "/etc/nginx/sites-enabled/$site_name" ]; then
        show_error "Site is not enabled."
        return 1
    fi

    echo -e "${YELLOW}Disabling site: $site_name${NC}"
    sudo rm "/etc/nginx/sites-enabled/$site_name"
    sudo nginx -t && sudo systemctl reload nginx
    show_success "Site disabled successfully."
    press_any_key
}