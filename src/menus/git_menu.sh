#!/bin/bash

# Git operations menu functions

# Display Git operations menu
show_git_menu() {
    clear
    echo -e "${BOLD_GREEN}Git Operations Menu${NC}"
    echo -e "${CYAN}1. Show Git Status${NC}"
    echo -e "${CYAN}2. Pull from Remote${NC}"
    echo -e "${CYAN}3. Push to Remote${NC}"
    echo -e "${CYAN}4. Add All Changes${NC}"
    echo -e "${CYAN}5. Commit Changes${NC}"
    echo -e "${CYAN}6. Remove Directory from Git Cache${NC}"
    echo -e "${CYAN}0. Back to Main Menu${NC}"
    echo -e "${BOLD_RED}9. Exit Program${NC}"
    echo -e "${YELLOW}Please enter your choice [0-9]:${NC}"
}

# Handle Git operations menu choices
git_operations_menu() {
    while true; do
        show_git_menu
        read -r choice

        case $choice in
            1)
                git_status
                ;;
            2)
                git_pull
                ;;
            3)
                git_push
                ;;
            4)
                git_add_all
                ;;
            5)
                git_commit
                ;;
            6)
                git_rm_cached_directory
                ;;
            0)
                break
                ;;
            9)
                exit_script
                ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                ;;
        esac
    done
}