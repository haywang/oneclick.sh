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
            2) port_management_menu ;;  # 端口管理
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
    echo -e "${GREEN}1. Add New User${NC}"
    echo -e "${GREEN}2. Delete User Only${NC}"
    echo -e "${GREEN}3. Delete User and Home Directory${NC}"
    echo -e "${GREEN}4. Delete User and All Files${NC}"
    echo -e "${GREEN}5. List All Users${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice [0-5]: ${NC}"
}

# Handle user management menu choices
delete_user_menu() {
    local choice

    while true; do
        show_user_management_menu
        read -r choice

        case $choice in
            1) add_new_user ;;
            2) delete_user_only ;;
            3) delete_user_and_home ;;
            4) delete_user_and_files ;;
            5) list_all_users ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
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

# Function to check which command is available
check_port_command() {
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

# Function to install net-tools if no port checking command is available
install_port_tools() {
    echo -e "${BOLD_RED}No port checking command found. Installing net-tools...${NC}"
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y net-tools
        echo "netstat"
    elif command -v yum &> /dev/null; then
        sudo yum install -y net-tools
        echo "netstat"
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y net-tools
        echo "netstat"
    elif command -v pacman &> /dev/null; then
        sudo pacman -S net-tools
        echo "netstat"
    else
        echo -e "${BOLD_RED}Unable to install net-tools. Please install it manually.${NC}"
        press_any_key
        echo ""
    fi
}

# Function to get available port checking command
get_port_command() {
    local cmd
    cmd=$(check_port_command)

    if [ -z "$cmd" ]; then
        cmd=$(install_port_tools)
    fi

    echo "$cmd"
}

# Function to show port information based on command
show_port_info() {
    local cmd="$1"
    local port="$2"

    case $cmd in
        "netstat")
            if [ -z "$port" ]; then
                sudo netstat -tulpn
            else
                sudo netstat -tulpn | grep ":$port "
            fi
            ;;
        "ss")
            if [ -z "$port" ]; then
                sudo ss -tulpn
            else
                sudo ss -tulpn | grep ":$port "
            fi
            ;;
        "lsof")
            if [ -z "$port" ]; then
                sudo lsof -i -P -n | grep LISTEN
            else
                sudo lsof -i:$port -P -n
            fi
            ;;
    esac
}

check_port_usage() {
    local cmd
    cmd=$(get_port_command)

    if [ -z "$cmd" ]; then
        return 1
    fi

    show_success "Current port usage (using $cmd):"
    show_port_info "$cmd"
    press_any_key
}

list_listening_ports() {
    local cmd
    cmd=$(get_port_command)

    if [ -z "$cmd" ]; then
        return 1
    fi

    show_success "All listening ports (using $cmd):"
    show_port_info "$cmd"
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

    local cmd
    cmd=$(get_port_command)

    if [ -z "$cmd" ]; then
        return 1
    fi

    show_success "Checking port $port (using $cmd):"
    show_port_info "$cmd" "$port"
    press_any_key
}