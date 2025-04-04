# Video download menu functions

# Display video download menu
show_video_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         VIDEO DOWNLOAD MENU          ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Download Single Video${NC}"
    echo -e "${GREEN}2. Download Playlist${NC}"
    echo -e "${GREEN}3. Download Video (Best Quality)${NC}"
    echo -e "${GREEN}4. Download Audio Only${NC}"
    echo -e "${GREEN}5. Show Available Formats${NC}"
    echo -e "${GREEN}6. Download Custom Format${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle video download menu choices
video_download_menu() {
    local choice

    while true; do
        show_video_menu
        read choice

        case $choice in
            1) download_single_video ;;
            2) download_playlist ;;
            3) download_best_quality ;;
            4) download_audio ;;
            5) show_formats ;;
            6) download_custom_format ;;
            0) break ;;
            *)
                echo -e "${BOLD_RED}Invalid option. Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}