# Video download menu functions

# Display video download menu
show_video_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}         VIDEO DOWNLOAD               ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Install/Update yt-dlp${NC}"
    echo -e "${GREEN}2. Download Single Video${NC}"
    echo -e "${GREEN}3. Download Playlist${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
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
            1) install_ytdlp ;;
            2) download_single_video ;;
            3) download_playlist ;;
            0) break ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}