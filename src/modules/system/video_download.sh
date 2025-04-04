# Video download functions

# Check if yt-dlp is installed and install if needed
check_ytdlp() {
    if ! command -v yt-dlp &> /dev/null; then
        echo -e "${YELLOW}yt-dlp not found. Installing...${NC}"
        if command -v pip3 &> /dev/null; then
            pip3 install --upgrade yt-dlp
        else
            echo -e "${RED}Error: pip3 not found. Please install Python3 and pip3 first.${NC}"
            sleep 2
            return 1
        fi
    fi
    return 0
}

# Download single video
download_single_video() {
    if ! check_ytdlp; then
        return 1
    fi

    echo -e "${CYAN}Enter video URL: ${NC}"
    read -r url

    if [ -z "$url" ]; then
        echo -e "${RED}Error: URL cannot be empty!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}Downloading video...${NC}"
    yt-dlp "$url"
    echo -e "${GREEN}Download completed!${NC}"
    sleep 2
}

# Download playlist
download_playlist() {
    if ! check_ytdlp; then
        return 1
    fi

    echo -e "${CYAN}Enter playlist URL: ${NC}"
    read -r url

    if [ -z "$url" ]; then
        echo -e "${RED}Error: URL cannot be empty!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}Downloading playlist...${NC}"
    yt-dlp --yes-playlist "$url"
    echo -e "${GREEN}Playlist download completed!${NC}"
    sleep 2
}

# Download video in best quality
download_best_quality() {
    if ! check_ytdlp; then
        return 1
    fi

    echo -e "${CYAN}Enter video URL: ${NC}"
    read -r url

    if [ -z "$url" ]; then
        echo -e "${RED}Error: URL cannot be empty!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}Downloading video in best quality...${NC}"
    yt-dlp -f bestvideo+bestaudio "$url"
    echo -e "${GREEN}Download completed!${NC}"
    sleep 2
}

# Download audio only
download_audio() {
    if ! check_ytdlp; then
        return 1
    fi

    echo -e "${CYAN}Enter video URL: ${NC}"
    read -r url

    if [ -z "$url" ]; then
        echo -e "${RED}Error: URL cannot be empty!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}Downloading audio...${NC}"
    yt-dlp -x --audio-format mp3 "$url"
    echo -e "${GREEN}Audio download completed!${NC}"
    sleep 2
}

# Show available formats
show_formats() {
    if ! check_ytdlp; then
        return 1
    fi

    echo -e "${CYAN}Enter video URL: ${NC}"
    read -r url

    if [ -z "$url" ]; then
        echo -e "${RED}Error: URL cannot be empty!${NC}"
        sleep 2
        return 1
    fi

    yt-dlp -F "$url"
    echo -e "\nPress Enter to continue..."
    read -r
}

# Download custom format
download_custom_format() {
    if ! check_ytdlp; then
        return 1
    fi

    echo -e "${CYAN}Enter video URL: ${NC}"
    read -r url

    if [ -z "$url" ]; then
        echo -e "${RED}Error: URL cannot be empty!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Available formats:${NC}"
    yt-dlp -F "$url"

    echo -e "${CYAN}Enter format code: ${NC}"
    read -r format_code

    if ! [[ "$format_code" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Error: Invalid format code!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}Downloading video in selected format...${NC}"
    yt-dlp -f "$format_code" "$url"
    echo -e "${GREEN}Download completed!${NC}"
    sleep 2
}