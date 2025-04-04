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