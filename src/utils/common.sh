# Common utility functions

# Check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Please run as root${NC}"
        exit 1
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
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

# Confirm action
confirm_action() {
    local message=$1
    local confirm

    read -p "$message (y/n): " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        return 0
    else
        return 1
    fi
}

# Show success message
show_success() {
    echo -e "${GREEN}$1${NC}"
}

# Show error message
show_error() {
    echo -e "${RED}$1${NC}"
}

# Show warning message
show_warning() {
    echo -e "${YELLOW}$1${NC}"
}

# Press any key to continue
press_any_key() {
    read -n 1 -s -r -p "Press any key to continue..."
    echo
}