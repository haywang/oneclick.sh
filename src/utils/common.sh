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

# Exit script with confirmation
exit_script() {
    clear
    echo -e "${BOLD_RED}========================================${NC}"
    echo -e "${BOLD_RED}           EXIT CONFIRMATION            ${NC}"
    echo -e "${BOLD_RED}========================================${NC}"

    if confirm_action "Are you sure you want to exit the program?"; then
        echo -e "${GREEN}Thank you for using the script! Goodbye.${NC}"
        sleep 1
        exit 0
    else
        echo -e "${CYAN}Exit cancelled. Returning to previous menu...${NC}"
        sleep 1
    fi
}