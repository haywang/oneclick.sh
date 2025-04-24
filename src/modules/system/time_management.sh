#!/bin/bash

# Functions for system time management

# Function to display current system time
display_current_time() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         CURRENT SYSTEM TIME            ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"

    echo -e "${CYAN}Current System Time:${NC}"
    date

    # Display timezone information
    echo -e "\n${CYAN}Current Timezone:${NC}"
    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        echo -e "$(systemsetup -gettimezone 2>/dev/null | awk '{print $3}')"
    else
        # Linux
        if [ -f /etc/timezone ]; then
            cat /etc/timezone
        elif [ -L /etc/localtime ]; then
            readlink -f /etc/localtime | sed 's#/usr/share/zoneinfo/##'
        else
            echo "Unknown (timedatectl might show more information)"
            timedatectl 2>/dev/null || echo "timedatectl not available"
        fi
    fi

    echo -e "\n${CYAN}Current NTP Status:${NC}"
    if command -v timedatectl &>/dev/null; then
        timedatectl status | grep -E "NTP|synchronized"
    elif command -v systemctl &>/dev/null && systemctl list-unit-files | grep -q ntp; then
        systemctl status ntp 2>/dev/null || echo "NTP service status unknown"
    elif [[ "$(uname)" == "Darwin" ]]; then
        systemsetup -getusingnetworktime
    else
        echo "NTP status unknown"
    fi

    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to set system date and time manually
set_system_time_manually() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}       SET SYSTEM TIME MANUALLY         ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"

    echo -e "${CYAN}Current System Time:${NC} $(date)"
    echo

    # Determine if we're root or need sudo
    SUDO=""
    if [[ $EUID -ne 0 ]]; then
        SUDO="sudo"
    fi

    echo -e "${CYAN}Enter the date in format YYYY-MM-DD:${NC}"
    read -r new_date

    echo -e "${CYAN}Enter the time in format HH:MM:SS (24-hour format):${NC}"
    read -r new_time

    if [[ -z "$new_date" || -z "$new_time" ]]; then
        echo -e "${BOLD_RED}Date or time cannot be empty.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Validate date format
    if ! [[ $new_date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo -e "${BOLD_RED}Invalid date format. Please use YYYY-MM-DD.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Validate time format
    if ! [[ $new_time =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
        echo -e "${BOLD_RED}Invalid time format. Please use HH:MM:SS.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${YELLOW}Are you sure you want to set the system time to $new_date $new_time? (y/N):${NC}"
    read -r confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        if [[ "$(uname)" == "Darwin" ]]; then
            # macOS uses a different date format
            if $SUDO date -f "%Y-%m-%d %H:%M:%S" -j "$new_date $new_time" &>/dev/null; then
                $SUDO date -f "%Y-%m-%d %H:%M:%S" "$new_date $new_time"
                echo -e "${GREEN}System time has been set successfully.${NC}"
            else
                echo -e "${BOLD_RED}Failed to set system time.${NC}"
            fi
        else
            # Linux
            if $SUDO date -s "$new_date $new_time" &>/dev/null; then
                echo -e "${GREEN}System time has been set successfully.${NC}"
                # If hardware clock is available, update it
                if command -v hwclock &>/dev/null; then
                    $SUDO hwclock --systohc
                    echo -e "${GREEN}Hardware clock has been updated.${NC}"
                fi
            else
                echo -e "${BOLD_RED}Failed to set system time.${NC}"
            fi
        fi
    else
        echo -e "${YELLOW}Operation cancelled.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to synchronize time with NTP server
sync_time_with_ntp() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}     SYNCHRONIZE TIME WITH NTP SERVER   ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"

    echo -e "${CYAN}Current System Time:${NC} $(date)"
    echo

    # Determine if we're root or need sudo
    SUDO=""
    if [[ $EUID -ne 0 ]]; then
        SUDO="sudo"
    fi

    # Check and install NTP if needed
    if ! command -v ntpdate &>/dev/null && ! command -v chronyd &>/dev/null && ! command -v timedatectl &>/dev/null; then
        echo -e "${YELLOW}NTP tools not found. Would you like to install them? (y/N):${NC}"
        read -r install_ntp

        if [[ "$install_ntp" =~ ^[Yy]$ ]]; then
            if command -v apt &>/dev/null; then
                $SUDO apt update
                $SUDO apt install -y ntp ntpdate
            elif command -v yum &>/dev/null; then
                $SUDO yum install -y ntp ntpdate
            elif command -v dnf &>/dev/null; then
                $SUDO dnf install -y ntp ntpdate
            elif command -v pacman &>/dev/null; then
                $SUDO pacman -S --noconfirm ntp
            elif [[ "$(uname)" == "Darwin" ]]; then
                echo -e "${YELLOW}macOS has built-in time synchronization. No need to install.${NC}"
            else
                echo -e "${BOLD_RED}Unable to install NTP tools automatically. Please install manually.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return 1
            fi
        else
            echo -e "${YELLOW}Operation cancelled.${NC}"
            echo -e "${CYAN}Press any key to continue...${NC}"
            read -n 1
            return 1
        fi
    fi

    echo -e "${CYAN}Choose an NTP server to sync with:${NC}"
    echo -e "1. pool.ntp.org (default)"
    echo -e "2. time.apple.com (Apple)"
    echo -e "3. time.windows.com (Microsoft)"
    echo -e "4. time.google.com (Google)"
    echo -e "5. Enter custom NTP server"

    read -r ntp_choice

    case $ntp_choice in
        1|"") ntp_server="pool.ntp.org" ;;
        2) ntp_server="time.apple.com" ;;
        3) ntp_server="time.windows.com" ;;
        4) ntp_server="time.google.com" ;;
        5)
            echo -e "${CYAN}Enter custom NTP server address:${NC}"
            read -r ntp_server
            if [[ -z "$ntp_server" ]]; then
                echo -e "${BOLD_RED}NTP server cannot be empty.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return 1
            fi
            ;;
        *)
            echo -e "${BOLD_RED}Invalid choice.${NC}"
            echo -e "${CYAN}Press any key to continue...${NC}"
            read -n 1
            return 1
            ;;
    esac

    echo -e "${YELLOW}Attempting to synchronize time with $ntp_server...${NC}"

    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        $SUDO systemsetup -setnetworktimeserver "$ntp_server"
        $SUDO systemsetup -setusingnetworktime on
        echo -e "${GREEN}Time server set to $ntp_server and network time enabled.${NC}"
    else
        # Linux
        if command -v timedatectl &>/dev/null; then
            # systemd systems
            $SUDO timedatectl set-ntp true
            echo -e "${GREEN}NTP synchronization enabled via timedatectl.${NC}"
        elif command -v ntpdate &>/dev/null; then
            # Try ntpdate for immediate sync
            $SUDO ntpdate "$ntp_server"
            echo -e "${GREEN}Time synchronized with $ntp_server using ntpdate.${NC}"

            # Check if ntpd or chronyd service exists, and enable it
            if command -v systemctl &>/dev/null; then
                if systemctl list-unit-files | grep -q ntp.service; then
                    $SUDO systemctl enable ntp.service
                    $SUDO systemctl restart ntp.service
                    echo -e "${GREEN}NTP service enabled and restarted.${NC}"
                elif systemctl list-unit-files | grep -q chronyd.service; then
                    $SUDO systemctl enable chronyd.service
                    $SUDO systemctl restart chronyd.service
                    echo -e "${GREEN}Chrony service enabled and restarted.${NC}"
                fi
            fi
        else
            echo -e "${BOLD_RED}Failed to synchronize time. No suitable NTP client found.${NC}"
        fi
    fi

    echo -e "${CYAN}Updated System Time:${NC} $(date)"
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to change system timezone
change_timezone() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         CHANGE SYSTEM TIMEZONE         ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"

    # Determine if we're root or need sudo
    SUDO=""
    if [[ $EUID -ne 0 ]]; then
        SUDO="sudo"
    fi

    # Display current timezone
    echo -e "${CYAN}Current Timezone:${NC}"
    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        current_tz=$(systemsetup -gettimezone 2>/dev/null | awk '{print $3}')
        echo -e "$current_tz"
    else
        # Linux
        if [ -f /etc/timezone ]; then
            cat /etc/timezone
        elif [ -L /etc/localtime ]; then
            readlink -f /etc/localtime | sed 's#/usr/share/zoneinfo/##'
        else
            echo "Unknown (timedatectl might show more information)"
            timedatectl 2>/dev/null || echo "timedatectl not available"
        fi
    fi

    echo

    # Common timezones for quick selection
    echo -e "${CYAN}Select a common timezone or enter a custom one:${NC}"
    echo -e "1. America/New_York (US Eastern)"
    echo -e "2. America/Chicago (US Central)"
    echo -e "3. America/Denver (US Mountain)"
    echo -e "4. America/Los_Angeles (US Pacific)"
    echo -e "5. Europe/London (UK)"
    echo -e "6. Europe/Paris (France)"
    echo -e "7. Europe/Berlin (Germany)"
    echo -e "8. Asia/Shanghai (China)"
    echo -e "9. Asia/Tokyo (Japan)"
    echo -e "10. Australia/Sydney (Australia)"
    echo -e "11. Enter custom timezone"
    echo -e "12. List all available timezones"

    read -r tz_choice

    case $tz_choice in
        1) timezone="America/New_York" ;;
        2) timezone="America/Chicago" ;;
        3) timezone="America/Denver" ;;
        4) timezone="America/Los_Angeles" ;;
        5) timezone="Europe/London" ;;
        6) timezone="Europe/Paris" ;;
        7) timezone="Europe/Berlin" ;;
        8) timezone="Asia/Shanghai" ;;
        9) timezone="Asia/Tokyo" ;;
        10) timezone="Australia/Sydney" ;;
        11)
            echo -e "${CYAN}Enter custom timezone (e.g., America/New_York):${NC}"
            read -r timezone
            if [[ -z "$timezone" ]]; then
                echo -e "${BOLD_RED}Timezone cannot be empty.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return 1
            fi
            ;;
        12)
            if [[ "$(uname)" == "Darwin" ]]; then
                echo -e "${CYAN}Available timezones:${NC}"
                sudo systemsetup -listtimezones | more
            else
                if [ -d /usr/share/zoneinfo ]; then
                    echo -e "${CYAN}Available timezones:${NC}"
                    find /usr/share/zoneinfo -type f -not -path "*/posix/*" -not -path "*/right/*" | sed 's#/usr/share/zoneinfo/##' | sort | more
                elif command -v timedatectl &>/dev/null; then
                    echo -e "${CYAN}Available timezones:${NC}"
                    timedatectl list-timezones | more
                else
                    echo -e "${BOLD_RED}Unable to list available timezones.${NC}"
                fi
            fi

            echo -e "${CYAN}Enter desired timezone:${NC}"
            read -r timezone
            if [[ -z "$timezone" ]]; then
                echo -e "${BOLD_RED}Timezone cannot be empty.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return 1
            fi
            ;;
        *)
            echo -e "${BOLD_RED}Invalid choice.${NC}"
            echo -e "${CYAN}Press any key to continue...${NC}"
            read -n 1
            return 1
            ;;
    esac

    echo -e "${YELLOW}Setting timezone to $timezone...${NC}"

    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        if $SUDO systemsetup -settimezone "$timezone" &>/dev/null; then
            echo -e "${GREEN}Timezone has been set to $timezone successfully.${NC}"
        else
            echo -e "${BOLD_RED}Failed to set timezone. Please make sure the timezone is valid.${NC}"
        fi
    else
        # Linux
        if command -v timedatectl &>/dev/null; then
            # systemd systems
            if $SUDO timedatectl set-timezone "$timezone" &>/dev/null; then
                echo -e "${GREEN}Timezone has been set to $timezone successfully.${NC}"
            else
                echo -e "${BOLD_RED}Failed to set timezone. Please make sure the timezone is valid.${NC}"
            fi
        else
            # Traditional method
            if [ -f "/usr/share/zoneinfo/$timezone" ]; then
                $SUDO ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime
                if [ -f /etc/timezone ]; then
                    echo "$timezone" | $SUDO tee /etc/timezone > /dev/null
                fi
                echo -e "${GREEN}Timezone has been set to $timezone successfully.${NC}"
            else
                echo -e "${BOLD_RED}Timezone $timezone not found. Please make sure the timezone is valid.${NC}"
            fi
        fi
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}