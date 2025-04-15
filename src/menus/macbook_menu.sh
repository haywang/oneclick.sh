# Macbook setup menu functions

# Display Macbook setup menu
show_macbook_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}          MACBOOK SETUP                ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Install iTerm2${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_RED}9. Exit Program${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle Macbook setup menu choices
macbook_setup_menu() {
    local choice

    while true; do
        show_macbook_menu
        read -r choice

        case $choice in
            1) open_iterm2_website ;;
            0) break ;;
            9) exit_script ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Open iTerm2 website
open_iterm2_website() {
    show_info "Opening iTerm2 website in your default browser..."

    # Check which command to use based on OS
    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS uses open command
        open "https://iterm2.com/index.html"
    else
        # Try various commands for Linux
        if command_exists xdg-open; then
            xdg-open "https://iterm2.com/index.html"
        elif command_exists gnome-open; then
            gnome-open "https://iterm2.com/index.html"
        else
            show_error "Unable to open URL automatically."
            show_info "Please visit: https://iterm2.com/index.html"
        fi
    fi

    show_success "iTerm2 website opened."
    press_any_key
}