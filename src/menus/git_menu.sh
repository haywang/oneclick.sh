# Git operations menu functions

# Display Git operations menu
show_git_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         GIT OPERATIONS MENU          ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Clean Git Cache${NC}"
    echo -e "${GREEN}2. Show Git Status${NC}"
    echo -e "${GREEN}3. Add All Changes${NC}"
    echo -e "${GREEN}4. Commit Changes${NC}"
    echo -e "${GREEN}5. Push to Remote${NC}"
    echo -e "${GREEN}6. Pull from Remote${NC}"
    echo -e "${GREEN}7. Show Git Log${NC}"
    echo -e "${YELLOW}0. Back${NC}"
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
            1) clean_git_cache ;;
            2) show_git_status ;;
            3) git_add_all ;;
            4) git_commit ;;
            5) git_push ;;
            6) git_pull ;;
            7) show_git_log ;;
            0) break ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}