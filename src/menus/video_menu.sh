# Video download menu functions

# Display video download menu
show_video_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}          VIDEO DOWNLOAD               ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Install/Update yt-dlp${NC}"
    echo -e "${GREEN}2. Check yt-dlp version${NC}"
    echo -e "${GREEN}3. Download single video${NC}"
    echo -e "${GREEN}4. Download playlist${NC}"
    echo -e "${GREEN}5. Download best quality video${NC}"
    echo -e "${GREEN}6. Download audio only${NC}"
    echo -e "${GREEN}7. Show available formats${NC}"
    echo -e "${GREEN}8. Download with custom format${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_RED}9. Exit Program${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Handle video download menu choices
video_download_menu() {
    local choice

    while true; do
        show_video_menu
        read -r choice

        case $choice in
            1) install_ytdlp ;;
            2) check_ytdlp_version ;;
            3) download_single_video ;;
            4) download_playlist ;;
            5) download_best_quality ;;
            6) download_audio_only ;;
            7) show_formats ;;
            8) download_custom_quality ;;
            0) return ;;
            9) exit_script ;;
            *)
                show_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}