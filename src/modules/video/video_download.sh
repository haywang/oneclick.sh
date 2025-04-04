# Video download functions

# Install or update yt-dlp
install_ytdlp() {
    if ! command_exists yt-dlp; then
        show_success "Installing yt-dlp..."
        if command_exists pip3; then
            pip3 install --upgrade yt-dlp
        else
            show_error "pip3 is not installed. Please install Python3 and pip3 first."
            return 1
        fi
    else
        show_success "Updating yt-dlp..."
        pip3 install --upgrade yt-dlp
    fi

    if command_exists yt-dlp; then
        show_success "yt-dlp installed/updated successfully"
        yt-dlp --version
    else
        show_error "Failed to install/update yt-dlp"
        return 1
    fi

    press_any_key
}

# Download single video
download_single_video() {
    local video_url=""
    local quality=""
    local format=""

    show_info "Enter video URL:"
    read -r video_url

    show_info "Select video quality:"
    echo "1) Best quality"
    echo "2) 1080p"
    echo "3) 720p"
    echo "4) 480p"
    echo "5) Audio only"
    read -r quality

    case $quality in
        1) format="bestvideo+bestaudio/best" ;;
        2) format="bestvideo[height<=1080]+bestaudio/best[height<=1080]" ;;
        3) format="bestvideo[height<=720]+bestaudio/best[height<=720]" ;;
        4) format="bestvideo[height<=480]+bestaudio/best[height<=480]" ;;
        5) format="bestaudio[ext=m4a]/bestaudio" ;;
        *) format="bestvideo+bestaudio/best" ;;
    esac

    show_success "Downloading video..."
    yt-dlp -f "$format" "$video_url"

    press_any_key
}

# Download playlist
download_playlist() {
    local playlist_url=""
    local quality=""
    local format=""
    local start_index=""
    local end_index=""

    show_info "Enter playlist URL:"
    read -r playlist_url

    show_info "Select video quality:"
    echo "1) Best quality"
    echo "2) 1080p"
    echo "3) 720p"
    echo "4) 480p"
    echo "5) Audio only"
    read -r quality

    case $quality in
        1) format="bestvideo+bestaudio/best" ;;
        2) format="bestvideo[height<=1080]+bestaudio/best[height<=1080]" ;;
        3) format="bestvideo[height<=720]+bestaudio/best[height<=720]" ;;
        4) format="bestvideo[height<=480]+bestaudio/best[height<=480]" ;;
        5) format="bestaudio[ext=m4a]/bestaudio" ;;
        *) format="bestvideo+bestaudio/best" ;;
    esac

    show_info "Enter start index (leave empty for beginning):"
    read -r start_index

    show_info "Enter end index (leave empty for end):"
    read -r end_index

    local range_opt=""
    if [ -n "$start_index" ] && [ -n "$end_index" ]; then
        range_opt="--playlist-start $start_index --playlist-end $end_index"
    elif [ -n "$start_index" ]; then
        range_opt="--playlist-start $start_index"
    elif [ -n "$end_index" ]; then
        range_opt="--playlist-end $end_index"
    fi

    show_success "Downloading playlist..."
    yt-dlp -f "$format" $range_opt "$playlist_url"

    press_any_key
}