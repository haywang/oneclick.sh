# User management functions

# Add a new user
add_new_user() {
    check_root

    local username
    echo -e "${CYAN}Enter username: ${NC}"
    read username

    if ! is_valid_username "$username"; then
        show_error "Invalid username format"
        return 1
    fi

    if id "$username" &>/dev/null; then
        show_error "User $username already exists"
        return 1
    fi

    if confirm_action "Do you want to set a password for $username?"; then
        sudo useradd -m -s /bin/bash "$username"
        sudo passwd "$username"
    else
        sudo useradd -m -s /bin/bash "$username" -p '*'
    fi

    if confirm_action "Do you want to add $username to sudo group?"; then
        sudo usermod -aG sudo "$username"
        show_success "User $username added to sudo group"
    fi

    show_success "User $username created successfully"
}

# Delete user only
delete_user_only() {
    check_root

    local username
    echo -e "${CYAN}Enter username to delete: ${NC}"
    read username

    if ! id "$username" &>/dev/null; then
        show_error "User $username does not exist"
        return 1
    fi

    if confirm_action "Are you sure you want to delete user $username?"; then
        sudo userdel "$username"
        show_success "User $username deleted successfully"
    else
        show_warning "Operation cancelled"
    fi
}

# Delete user and home directory
delete_user_and_home() {
    check_root

    local username
    echo -e "${CYAN}Enter username to delete: ${NC}"
    read username

    if ! id "$username" &>/dev/null; then
        show_error "User $username does not exist"
        return 1
    fi

    if confirm_action "Are you sure you want to delete user $username and their home directory?"; then
        sudo userdel -r "$username"
        show_success "User $username and home directory deleted successfully"
    else
        show_warning "Operation cancelled"
    fi
}

# Delete user and all files
delete_user_and_files() {
    check_root

    local username
    echo -e "${CYAN}Enter username to delete: ${NC}"
    read username

    if ! id "$username" &>/dev/null; then
        show_error "User $username does not exist"
        return 1
    fi

    echo -e "${YELLOW}Files owned by $username:${NC}"
    sudo find / -user "$username" 2>/dev/null

    if confirm_action "Are you sure you want to delete user $username and ALL their files?"; then
        sudo find / -user "$username" -delete 2>/dev/null
        sudo userdel -r "$username"
        show_success "User $username and all their files deleted successfully"
    else
        show_warning "Operation cancelled"
    fi
}

# List all users
list_all_users() {
    echo -e "${CYAN}System Users (UID >= 1000):${NC}"
    awk -F: '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd

    local count
    count=$(awk -F: '$3 >= 1000 && $3 != 65534 {count++} END {print count}' /etc/passwd)
    echo -e "${GREEN}Total users: $count${NC}"

    press_any_key
}