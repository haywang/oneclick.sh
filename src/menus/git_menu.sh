#!/bin/bash

# Git operations menu functions

# Display Git operations menu
show_git_menu() {
clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         Git Operations Menu             ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Show Git Status${NC}"
    echo -e "${GREEN}2. Pull from Remote${NC}"
    echo -e "${GREEN}3. Push to Remote${NC}"
    echo -e "${GREEN}4. Add All Changes${NC}"
    echo -e "${GREEN}5. Commit Changes${NC}"
    echo -e "${GREEN}6. Remove Directory from Git Cache${NC}"
    echo -e "${GREEN}7. Set Git HTTP/HTTPS Proxy${NC}"
    echo -e "${GREEN}8. Remove Git Proxy Settings${NC}"
    echo -e "${YELLOW}0. Back to Main Menu${NC}"
    echo -e "${BOLD_RED}9. Exit Program${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
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
            7)
                git_set_proxy
                ;;
            8)
                git_unset_proxy
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