# Operations management menu functions

# Display PM2 management menu
show_pm2_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         PM2 MANAGEMENT               ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Start application${NC}"
    echo -e "${GREEN}2. Stop application${NC}"
    echo -e "${GREEN}3. Restart application${NC}"
    echo -e "${GREEN}4. List applications${NC}"
    echo -e "${GREEN}5. Show logs${NC}"
    echo -e "${GREEN}6. Monitor applications${NC}"
    echo -e "${YELLOW}0. Back to operations menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle PM2 management menu choices
pm2_management_menu() {
    local choice

    while true; do
        show_pm2_menu
        read choice

        case $choice in
            1) pm2_start_app ;;
            2) pm2_stop_app ;;
            3) pm2_restart_app ;;
            4) pm2_list_apps ;;
            5) pm2_show_logs ;;
            6) pm2_monitor ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Display Nginx management menu
show_nginx_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         NGINX MANAGEMENT             ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Start Nginx${NC}"
    echo -e "${GREEN}2. Stop Nginx${NC}"
    echo -e "${GREEN}3. Restart Nginx${NC}"
    echo -e "${GREEN}4. Reload configuration${NC}"
    echo -e "${GREEN}5. Test configuration${NC}"
    echo -e "${GREEN}6. Show status${NC}"
    echo -e "${GREEN}7. Edit configuration${NC}"
    echo -e "${GREEN}8. List sites${NC}"
    echo -e "${GREEN}9. Enable site${NC}"
    echo -e "${GREEN}10. Disable site${NC}"
    echo -e "${YELLOW}0. Back to operations menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle Nginx management menu choices
nginx_management_menu() {
    local choice

    while true; do
        show_nginx_menu
        read choice

        case $choice in
            1) nginx_start ;;
            2) nginx_stop ;;
            3) nginx_restart ;;
            4) nginx_reload ;;
            5) nginx_test_config ;;
            6) nginx_show_status ;;
            7) nginx_edit_config ;;
            8) nginx_list_sites ;;
            9) nginx_enable_site ;;
            10) nginx_disable_site ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Display operations management menu
show_ops_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}      OPERATIONS MANAGEMENT          ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. PM2 Management${NC}"
    echo -e "${GREEN}2. Nginx Management${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle operations management menu choices
ops_management_menu() {
    local choice

    while true; do
        show_ops_menu
        read choice

        case $choice in
            1) pm2_management_menu ;;
            2) nginx_management_menu ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}