# Git operations menu functions

# Display Git operations menu
show_git_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         GIT OPERATIONS               ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Clear Git Cache${NC}"
    echo -e "${GREEN}2. Show Repository Status${NC}"
    echo -e "${GREEN}3. Pull Latest Changes${NC}"
    echo -e "${GREEN}4. Push Changes${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle Git operations menu choices
git_operations_menu() {
    local choice

    while true; do
        show_git_menu
        read choice

        case $choice in
            1) clear_git_cache ;;
            2) show_git_status ;;
            3) git_pull_latest ;;
            4) git_push_changes ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}