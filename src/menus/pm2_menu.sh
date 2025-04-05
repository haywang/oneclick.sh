#!/bin/bash

# Function to display PM2 Management submenu
show_pm2_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         PM2 MANAGEMENT               ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Start Application${NC}"
    echo -e "${GREEN}2. List All Applications${NC}"
    echo -e "${GREEN}3. Stop Application${NC}"
    echo -e "${GREEN}4. Restart Application${NC}"
    echo -e "${GREEN}5. Reload Application${NC}"
    echo -e "${GREEN}6. Delete Application${NC}"
    echo -e "${GREEN}7. Show Logs${NC}"
    echo -e "${GREEN}8. Monitor Applications${NC}"
    echo -e "${GREEN}9. Startup Setup${NC}"
    echo -e "${GREEN}10. Save Process List${NC}"
    echo -e "${GREEN}11. Update PM2${NC}"
    echo -e "${GREEN}12. Kill PM2 Daemon${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# PM2 Management Functions
pm2_start_app() {
    clear
    echo -e "${BOLD_GREEN}Start PM2 Application${NC}"
    echo -e "${CYAN}Enter application path (e.g., app.js): ${NC}"
    read app_path

    if [ -z "$app_path" ]; then
        echo -e "${BOLD_RED}Application path cannot be empty.${NC}"
    else
        echo -e "${CYAN}Enter application name (optional, press Enter to skip): ${NC}"
        read app_name

        if [ -n "$app_name" ]; then
            pm2 start "$app_path" --name "$app_name"
        else
            pm2 start "$app_path"
        fi

        echo -e "${GREEN}Application started.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_list_apps() {
    clear
    echo -e "${BOLD_GREEN}Listing All PM2 Applications${NC}"
    pm2 list
    echo -e "\n${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_stop_app() {
    clear
    echo -e "${BOLD_GREEN}Stop PM2 Application${NC}"
    pm2 list
    echo -e "\n${CYAN}Enter application name/id to stop: ${NC}"
    read app_id

    if [ -n "$app_id" ]; then
        pm2 stop "$app_id"
        echo -e "${GREEN}Application stopped.${NC}"
    else
        echo -e "${BOLD_RED}Application name/id cannot be empty.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_restart_app() {
    clear
    echo -e "${BOLD_GREEN}Restart PM2 Application${NC}"
    pm2 list
    echo -e "\n${CYAN}Enter application name/id to restart: ${NC}"
    read app_id

    if [ -n "$app_id" ]; then
        pm2 restart "$app_id"
        echo -e "${GREEN}Application restarted.${NC}"
    else
        echo -e "${BOLD_RED}Application name/id cannot be empty.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_reload_app() {
    clear
    echo -e "${BOLD_GREEN}Reload PM2 Application${NC}"
    pm2 list
    echo -e "\n${CYAN}Enter application name/id to reload: ${NC}"
    read app_id

    if [ -n "$app_id" ]; then
        pm2 reload "$app_id"
        echo -e "${GREEN}Application reloaded.${NC}"
    else
        echo -e "${BOLD_RED}Application name/id cannot be empty.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_delete_app() {
    clear
    echo -e "${BOLD_GREEN}Delete PM2 Application${NC}"
    pm2 list
    echo -e "\n${CYAN}Enter application name/id to delete (or 'all' for all apps): ${NC}"
    read app_id

    if [ -n "$app_id" ]; then
        echo -e "${YELLOW}Are you sure you want to delete '$app_id'? (y/N): ${NC}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            pm2 delete "$app_id"
            echo -e "${GREEN}Application(s) deleted.${NC}"
        else
            echo -e "${CYAN}Operation cancelled.${NC}"
        fi
    else
        echo -e "${BOLD_RED}Application name/id cannot be empty.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_show_logs() {
    clear
    echo -e "${BOLD_GREEN}Show PM2 Logs${NC}"
    echo -e "${CYAN}Options:${NC}"
    echo -e "${GREEN}1. Show all logs${NC}"
    echo -e "${GREEN}2. Show specific application logs${NC}"
    echo -e "${GREEN}3. Show last N lines${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    read -r choice

    case $choice in
        1)
            pm2 logs | cat
            ;;
        2)
            pm2 list
            echo -e "\n${CYAN}Enter application name/id: ${NC}"
            read app_id
            if [ -n "$app_id" ]; then
                pm2 logs "$app_id" | cat
            fi
            ;;
        3)
            echo -e "${CYAN}Enter number of lines: ${NC}"
            read lines
            if [ -n "$lines" ]; then
                pm2 logs --lines "$lines" | cat
            fi
            ;;
        0)
            return
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option.${NC}"
            ;;
    esac
}

pm2_monitor() {
    clear
    echo -e "${BOLD_GREEN}Monitoring PM2 Applications${NC}"
    pm2 monit
}

pm2_setup_startup() {
    clear
    echo -e "${BOLD_GREEN}Setting up PM2 Startup Script${NC}"
    pm2 startup
    echo -e "${YELLOW}Follow the instructions above if any command needs to be executed.${NC}"
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_save_process_list() {
    clear
    echo -e "${BOLD_GREEN}Saving Current Process List${NC}"
    pm2 save
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_update() {
    clear
    echo -e "${BOLD_GREEN}Updating PM2${NC}"
    echo -e "${CYAN}Installing latest PM2 version...${NC}"
    npm install pm2@latest -g

    echo -e "${CYAN}Updating PM2 in-memory...${NC}"
    pm2 update

    echo -e "${GREEN}PM2 has been updated to the latest version.${NC}"
    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

pm2_kill() {
    clear
    echo -e "${BOLD_GREEN}Kill PM2 Daemon${NC}"
    echo -e "${YELLOW}Warning: This will stop all running PM2 processes and kill the PM2 daemon.${NC}"
    echo -e "${YELLOW}Are you sure you want to continue? (y/N): ${NC}"
    read -r response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo -e "${CYAN}Killing PM2 daemon...${NC}"
        pm2 kill
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}PM2 daemon has been killed successfully.${NC}"
        else
            echo -e "${BOLD_RED}Failed to kill PM2 daemon.${NC}"
        fi
    else
        echo -e "${CYAN}Operation cancelled.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# PM2 Management menu handler
pm2_management_menu() {
    local choice

    while true; do
        show_pm2_menu
        read choice

        case $choice in
            1) pm2_start_app ;;
            2) pm2_list_apps ;;
            3) pm2_stop_app ;;
            4) pm2_restart_app ;;
            5) pm2_reload_app ;;
            6) pm2_delete_app ;;
            7) pm2_show_logs ;;
            8) pm2_monitor ;;
            9) pm2_setup_startup ;;
            10) pm2_save_process_list ;;
            11) pm2_update ;;
            12) pm2_kill ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}
