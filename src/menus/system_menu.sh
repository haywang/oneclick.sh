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
    echo -e "${GREEN}5. System Information${NC}"
    echo -e "${GREEN}6. Time Management${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_RED}9. Exit Program${NC}"
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
            5) show_system_info ;;  # 系统信息
            6) time_management_menu ;;  # 时间管理
            0) break ;;
            9) exit_script ;;
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
    echo -e "${BOLD_RED}9. Exit Program${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice [0-9]: ${NC}"
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
            9) exit_script ;;
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
    echo -e "${BOLD_RED}9. Exit Program${NC}"
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
            9) exit_script ;;
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

# System information function
show_system_info() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         SYSTEM INFORMATION            ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "\n${BOLD_CYAN}System Uptime:${NC}"
    if [[ "$(uname)" == "Darwin" ]]; then
        uptime
    else
        if [ -f /proc/uptime ]; then
            uptime
        else
            echo "Uptime information not available"
        fi
    fi

    echo -e "\n${BOLD_CYAN}Last System Boot:${NC}"
    if command -v who &> /dev/null; then
        who -b
    elif [[ "$(uname)" == "Darwin" ]]; then
        sysctl -n kern.boottime
    else
        echo "Last boot information not available"
    fi

    if command -v hostnamectl &> /dev/null; then
        echo -e "\n${BOLD_CYAN}Hostname and Virtualization:${NC}"
        hostnamectl
    fi

    # OS information
    echo -e "${BOLD_CYAN}Operating System:${NC}"

    # Check if lsb_release exists
    if command -v lsb_release &> /dev/null; then
        lsb_release -a 2>/dev/null
    else
        # Try various OS release files
        if [ -f /etc/os-release ]; then
            cat /etc/os-release | grep -E "PRETTY_NAME|VERSION|NAME" | sort
        elif [ -f /etc/redhat-release ]; then
            cat /etc/redhat-release
        elif [ -f /etc/debian_version ]; then
            echo "Debian $(cat /etc/debian_version)"
        elif [[ "$(uname)" == "Darwin" ]]; then
            echo "macOS $(sw_vers -productVersion) ($(sw_vers -buildVersion))"
            echo "Product Name: $(sw_vers -productName)"
        else
            echo "OS information not available"
        fi
    fi

    echo -e "\n${BOLD_CYAN}Kernel Information:${NC}"
    uname -a

    # Hardware information
    echo -e "\n${BOLD_CYAN}CPU Information:${NC}"
    if [[ "$(uname)" == "Darwin" ]]; then
        sysctl -n machdep.cpu.brand_string
        echo "Cores: $(sysctl -n hw.physicalcpu) (Physical), $(sysctl -n hw.logicalcpu) (Logical)"
    else
        if [ -f /proc/cpuinfo ]; then
            grep -m 1 "model name" /proc/cpuinfo | cut -d ":" -f 2 | sed 's/^[ \t]*//'
            echo "Cores: $(grep -c "processor" /proc/cpuinfo)"
        else
            echo "CPU information not available"
        fi
    fi

    echo -e "\n${BOLD_CYAN}Memory Information:${NC}"
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "Total Physical Memory: $(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024)) GB"
    else
        if command -v free &> /dev/null; then
            free -h | grep -E "Mem|total"
        elif [ -f /proc/meminfo ]; then
            grep -E "MemTotal|MemFree|MemAvailable|SwapTotal|SwapFree" /proc/meminfo
        else
            echo "Memory information not available"
        fi
    fi

    echo -e "\n${BOLD_CYAN}Disk Information:${NC}"
    if command -v df &> /dev/null; then
        df -h | grep -v "tmpfs\|udev\|loop" | sort
    else
        echo "Disk information not available"
    fi

    echo -e "\n${BOLD_CYAN}Network Information:${NC}"
    if [[ "$(uname)" == "Darwin" ]]; then
        # Get primary interface on macOS
        primary_interface=$(route -n get default | grep interface | awk '{print $2}')
        echo "Primary Interface: $primary_interface"
        ifconfig $primary_interface | grep -E "inet |status"
    else
        if command -v ip &> /dev/null; then
            ip addr | grep -E "inet |link/ether" | grep -v "127.0.0.1" | grep -v "::1"
        elif command -v ifconfig &> /dev/null; then
            ifconfig | grep -E "inet |ether" | grep -v "127.0.0.1" | grep -v "::1"
        else
            echo "Network information not available"
        fi
    fi

    echo -e "\n${BOLD_GREEN}========================================${NC}"
    press_any_key
}

# Display time management menu
show_time_management_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         TIME MANAGEMENT              ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Display Current Time and Timezone${NC}"
    echo -e "${GREEN}2. Set System Time Manually${NC}"
    echo -e "${GREEN}3. Synchronize Time with NTP Server${NC}"
    echo -e "${GREEN}4. Change System Timezone${NC}"
    echo -e "${YELLOW}0. Back to System Menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle time management menu choices
time_management_menu() {
    local choice

    while true; do
        show_time_management_menu
        read -r choice

        case $choice in
            1) display_current_time ;;
            2) set_system_time_manually ;;
            3) sync_time_with_ntp ;;
            4) change_timezone ;;
            0) break ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                ;;
        esac
    done
}