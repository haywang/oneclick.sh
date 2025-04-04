# System management menu functions

# Display system management menu
show_system_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         SYSTEM MANAGEMENT            ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. User Management${NC}"
    echo -e "${GREEN}2. Port Management${NC}"
    echo -e "${GREEN}3. UFW Firewall${NC}"
    echo -e "${GREEN}4. System Monitor${NC}"
    echo -e "${GREEN}5. Disk Usage${NC}"
    echo -e "${GREEN}6. Memory Usage${NC}"
    echo -e "${GREEN}7. Process Management${NC}"
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
            1) user_management_menu ;;
            2) port_management_menu ;;
            3) ufw_management_menu ;;
            4) system_monitor ;;
            5) disk_usage ;;
            6) memory_usage ;;
            7) process_management ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
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
    echo -e "${GREEN}1. Add New User${NC}"
    echo -e "${GREEN}2. Delete User${NC}"
    echo -e "${GREEN}3. List All Users${NC}"
    echo -e "${GREEN}4. Change User Password${NC}"
    echo -e "${GREEN}5. Add User to Group${NC}"
    echo -e "${YELLOW}0. Back to system menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle user management menu choices
user_management_menu() {
    local choice

    while true; do
        show_user_management_menu
        read choice

        case $choice in
            1) add_new_user ;;
            2) delete_user_menu ;;
            3) list_all_users ;;
            4) change_user_password ;;
            5) add_user_to_group ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
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