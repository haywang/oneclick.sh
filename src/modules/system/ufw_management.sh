# UFW management functions

# Install UFW
install_ufw() {
    if command -v ufw &> /dev/null; then
        echo -e "${YELLOW}UFW is already installed.${NC}"
        sleep 2
        return 0
    fi

    echo -e "${YELLOW}Installing UFW...${NC}"
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y ufw
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y ufw
    elif command -v yum &> /dev/null; then
        sudo yum install -y ufw
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy ufw
    else
        echo -e "${RED}Unable to detect package manager. Please install UFW manually.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${GREEN}UFW installed successfully!${NC}"
    sleep 2
}

# Enable UFW
enable_ufw() {
    if ! command -v ufw &> /dev/null; then
        echo -e "${RED}UFW is not installed. Please install it first.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}WARNING: Enabling UFW will block all incoming connections by default.${NC}"
    echo -e "${YELLOW}Do you want to allow SSH (port 22) before enabling UFW? (y/n)${NC}"
    read -r allow_ssh

    if [[ "$allow_ssh" =~ ^[Yy]$ ]]; then
        sudo ufw allow 22/tcp
        echo -e "${GREEN}SSH access has been allowed.${NC}"
    fi

    echo -e "${YELLOW}Enabling UFW...${NC}"
    sudo ufw --force enable
    echo -e "${GREEN}UFW has been enabled.${NC}"
    sleep 2
}

# Disable UFW
disable_ufw() {
    if ! command -v ufw &> /dev/null; then
        echo -e "${RED}UFW is not installed.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}WARNING: Disabling UFW will remove all firewall protection.${NC}"
    echo -e "${YELLOW}Are you sure you want to continue? (y/n)${NC}"
    read -r confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        sudo ufw disable
        echo -e "${GREEN}UFW has been disabled.${NC}"
    else
        echo -e "${YELLOW}Operation cancelled.${NC}"
    fi
    sleep 2
}

# Show UFW status
show_ufw_status() {
    if ! command -v ufw &> /dev/null; then
        echo -e "${RED}UFW is not installed.${NC}"
        sleep 2
        return 1
    fi

    sudo ufw status verbose
    echo -e "\nPress Enter to continue..."
    read -r
}

# Allow port with protocol selection
allow_port() {
    if ! command -v ufw &> /dev/null; then
        echo -e "${RED}UFW is not installed.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Enter the port number to allow: ${NC}"
    read -r port

    if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
        echo -e "${RED}Invalid port number. Must be between 1 and 65535.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Select protocol:${NC}"
    echo "1. TCP"
    echo "2. UDP"
    echo "3. Both TCP and UDP"
    read -r protocol_choice

    case $protocol_choice in
        1) sudo ufw allow "$port"/tcp ;;
        2) sudo ufw allow "$port"/udp ;;
        3) sudo ufw allow "$port" ;;
        *)
            echo -e "${RED}Invalid choice.${NC}"
            sleep 2
            return 1
            ;;
    esac

    echo -e "${GREEN}Port $port has been allowed.${NC}"
    sleep 2
}

# Deny port with protocol selection
deny_port() {
    if ! command -v ufw &> /dev/null; then
        echo -e "${RED}UFW is not installed.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Enter the port number to deny: ${NC}"
    read -r port

    if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
        echo -e "${RED}Invalid port number. Must be between 1 and 65535.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Select protocol:${NC}"
    echo "1. TCP"
    echo "2. UDP"
    echo "3. Both TCP and UDP"
    read -r protocol_choice

    case $protocol_choice in
        1) sudo ufw deny "$port"/tcp ;;
        2) sudo ufw deny "$port"/udp ;;
        3) sudo ufw deny "$port" ;;
        *)
            echo -e "${RED}Invalid choice.${NC}"
            sleep 2
            return 1
            ;;
    esac

    echo -e "${GREEN}Port $port has been denied.${NC}"
    sleep 2
}

# Delete UFW rule
delete_ufw_rule() {
    if ! command -v ufw &> /dev/null; then
        echo -e "${RED}UFW is not installed.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Current UFW rules:${NC}"
    sudo ufw status numbered

    echo -e "${CYAN}Enter the rule number to delete: ${NC}"
    read -r rule_number

    if ! [[ "$rule_number" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Invalid rule number.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}Are you sure you want to delete rule $rule_number? (y/n)${NC}"
    read -r confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        sudo ufw delete "$rule_number"
        echo -e "${GREEN}Rule $rule_number has been deleted.${NC}"
    else
        echo -e "${YELLOW}Operation cancelled.${NC}"
    fi
    sleep 2
}

# Reset UFW rules
reset_ufw_rules() {
    if ! command -v ufw &> /dev/null; then
        echo -e "${RED}UFW is not installed.${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}WARNING: This will reset all UFW rules to default.${NC}"
    echo -e "${YELLOW}Do you want to keep SSH access (port 22)? (y/n)${NC}"
    read -r keep_ssh

    echo -e "${YELLOW}Are you sure you want to reset all rules? (y/n)${NC}"
    read -r confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        sudo ufw reset
        sudo ufw default deny incoming
        sudo ufw default allow outgoing

        if [[ "$keep_ssh" =~ ^[Yy]$ ]]; then
            sudo ufw allow 22/tcp
            echo -e "${GREEN}SSH access has been preserved.${NC}"
        fi

        sudo ufw enable
        echo -e "${GREEN}UFW rules have been reset.${NC}"
    else
        echo -e "${YELLOW}Operation cancelled.${NC}"
    fi
    sleep 2
}

# Show UFW rules in numbered format
show_ufw_rules() {
    if ! command -v ufw &> /dev/null; then
        echo -e "${RED}UFW is not installed.${NC}"
        sleep 2
        return 1
    fi

    sudo ufw status numbered
    echo -e "\nPress Enter to continue..."
    read -r
}