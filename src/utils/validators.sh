# Input validation functions

# Validate if input is a number
is_number() {
    local input=$1
    [[ $input =~ ^[0-9]+$ ]]
}

# Validate if input is empty
is_empty() {
    local input=$1
    [[ -z "$input" ]]
}

# Validate if input is a valid port number
is_valid_port() {
    local port=$1
    if ! is_number "$port"; then
        return 1
    fi
    if [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
        return 1
    fi
    return 0
}

# Validate if input is a valid IP address
is_valid_ip() {
    local ip=$1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        local IFS='.'
        read -ra ip_array <<< "$ip"
        for octet in "${ip_array[@]}"; do
            if [ "$octet" -lt 0 ] || [ "$octet" -gt 255 ]; then
                return 1
            fi
        done
        return 0
    fi
    return 1
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