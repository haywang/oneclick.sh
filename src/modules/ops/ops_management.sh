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