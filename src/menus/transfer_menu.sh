# File transfer menu functions

# Display file transfer menu
show_file_transfer_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         FILE TRANSFER                ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. SCP Transfer${NC}"
    echo -e "${GREEN}2. Rsync Synchronization${NC}"
    echo -e "${GREEN}3. Generate SSH Key${NC}"
    echo -e "${GREEN}4. Copy SSH Key to Server${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_RED}9. Exit Program${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle file transfer menu choices
file_transfer_menu() {
    local choice

    while true; do
        show_file_transfer_menu
        read choice

        case $choice in
            1) scp_transfer ;;
            2) rsync_sync ;;
            3) generate_ssh_key ;;
            4) copy_ssh_key ;;
            0) break ;;
            9) exit_script ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}