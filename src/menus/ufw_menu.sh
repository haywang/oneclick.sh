# UFW management menu functions

# Display UFW management menu
show_ufw_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}          UFW MANAGEMENT              ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Install UFW${NC}"
    echo -e "${GREEN}2. Enable UFW${NC}"
    echo -e "${GREEN}3. Disable UFW${NC}"
    echo -e "${GREEN}4. Show UFW Status${NC}"
    echo -e "${GREEN}5. Allow Port${NC}"
    echo -e "${GREEN}6. Deny Port${NC}"
    echo -e "${GREEN}7. Delete Rule${NC}"
    echo -e "${GREEN}8. Reset UFW Rules${NC}"
    echo -e "${GREEN}9. Show UFW Rules Numbered${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle UFW management menu choices
ufw_management_menu() {
    local choice

    while true; do
        show_ufw_menu
        read choice

        case $choice in
            1) install_ufw ;;
            2) enable_ufw ;;
            3) disable_ufw ;;
            4) show_ufw_status ;;
            5) allow_port ;;
            6) deny_port ;;
            7) delete_ufw_rule ;;
            8) reset_ufw_rules ;;
            9) show_ufw_rules ;;
            0) break ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}