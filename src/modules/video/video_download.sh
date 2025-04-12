# Video download functions

# Check if yt-dlp is installed
check_ytdlp_installed() {
    if ! command_exists yt-dlp; then
        show_error "yt-dlp is not installed. Please install it first using the 'Install/Update yt-dlp' option."
        press_any_key
        return 1
    fi
    return 0
}

# Check yt-dlp version
check_ytdlp_version() {
    if ! check_ytdlp_installed; then
        return 1
    fi

    show_success "Current yt-dlp version:"
    yt-dlp --version

    press_any_key
}

# Install or update yt-dlp
install_ytdlp() {
    if ! command_exists yt-dlp; then
        # 如果未安装，则进行安装
        show_success "Installing yt-dlp..."

        # 优先检查brew是否存在
        if command_exists brew; then
            show_success "Using Homebrew to install yt-dlp..."
            brew install yt-dlp

            if command_exists yt-dlp; then
                show_success "yt-dlp installed successfully with Homebrew to version:"
                yt-dlp --version
                press_any_key
                return 0
            else
                show_warning "Failed to install yt-dlp with Homebrew. Trying pip3 method..."
            fi
        else
            show_warning "Homebrew not found. Trying pip3 method..."
        fi

        # 如果brew不存在或安装失败，则检查pip3
        if ! command_exists pip3; then
            show_warning "pip3 is not installed. Attempting to install Python3 and pip3..."

            # 根据系统安装Python和pip
            if [[ "$(uname -s)" == "Darwin" ]]; then
                # macOS - 使用homebrew
                if ! command_exists brew; then
                    show_error "Homebrew is not installed. Please install it first to install Python3."
                    press_any_key
                    return 1
                fi

                brew install python3
            else
                # Linux系统
                if command_exists apt-get; then
                    sudo apt-get update
                    sudo apt-get install -y python3 python3-pip
                elif command_exists yum; then
                    sudo yum install -y python3 python3-pip
                elif command_exists dnf; then
                    sudo dnf install -y python3 python3-pip
                else
                    show_error "Could not determine package manager. Please install Python3 and pip3 manually."
                    press_any_key
                    return 1
                fi
            fi
        fi

        # 再次检查pip3是否已安装
        if ! command_exists pip3; then
            show_error "Failed to install pip3. Please install Python3 and pip3 manually."
            press_any_key
            return 1
        fi

        # 使用pip3安装yt-dlp
        show_success "Installing yt-dlp with pip3..."
        pip3 install yt-dlp

        if command_exists yt-dlp; then
            show_success "yt-dlp installed successfully to version:"
            yt-dlp --version
        else
            show_error "Failed to install yt-dlp"
            press_any_key
            return 1
        fi
    else
        # 如果已安装，则检查更新
        show_success "yt-dlp is already installed."
        show_success "Current version:"
        yt-dlp --version

        show_success "Checking for updates..."

        local has_update=false

        # 根据安装方式检查更新
        if command_exists brew && brew list | grep -q yt-dlp; then
            # 使用brew检查更新
            brew outdated yt-dlp
            if [ $? -eq 0 ]; then
                show_warning "Already the latest version. No update needed."
                press_any_key
                return 0
            else
                show_success "New version available."
                has_update=true
            fi
        else
            # 使用pip检查更新
            if ! command_exists pip3; then
                show_error "pip3 not installed. Cannot check for updates."
                press_any_key
                return 1
            fi

            # 检查pip安装的更新
            pip3 list --outdated | grep yt-dlp
            if [ $? -ne 0 ]; then
                show_warning "Already the latest version. No update needed."
                press_any_key
                return 0
            else
                show_success "New version available."
                has_update=true
            fi
        fi

        # 如果有更新可用，询问用户是否要更新
        if $has_update; then
            show_info "Do you want to update yt-dlp? [y/n]"
            read -r update_choice

            if [[ "$update_choice" != "y" && "$update_choice" != "Y" ]]; then
                show_warning "Update cancelled."
                press_any_key
                return 0
            fi

            show_success "Updating yt-dlp..."

            # 根据安装方式进行更新
            if command_exists brew && brew list | grep -q yt-dlp; then
                # 通过Homebrew更新
                show_success "Updating yt-dlp with Homebrew..."
                brew upgrade yt-dlp
            else
                # 通过pip更新
                if ! command_exists pip3; then
                    show_error "pip3 not installed. Cannot update."
                    press_any_key
                    return 1
                fi

                show_success "Updating yt-dlp with pip3..."
                pip3 install --upgrade yt-dlp
            fi

            if [ $? -eq 0 ]; then
                show_success "yt-dlp updated successfully. New version:"
                yt-dlp --version
            else
                show_error "Failed to update yt-dlp"
                press_any_key
                return 1
            fi
        fi
    fi

    press_any_key
}

# Download single video
download_single_video() {
    if ! check_ytdlp_installed; then
        return 1
    fi

    local video_url=""
    local quality=""
    local format=""

    show_info "Enter video URL:"
    read -r video_url

    if [ -z "$video_url" ]; then
        show_error "URL cannot be empty"
        press_any_key
        return 1
    fi

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

    if [ $? -eq 0 ]; then
        show_success "Video downloaded successfully"
    else
        show_error "Failed to download video"
    fi

    press_any_key
}

# Download playlist
download_playlist() {
    if ! check_ytdlp_installed; then
        return 1
    fi

    local playlist_url=""
    local quality=""
    local format=""
    local start_index=""
    local end_index=""

    show_info "Enter playlist URL:"
    read -r playlist_url

    if [ -z "$playlist_url" ]; then
        show_error "URL cannot be empty"
        press_any_key
        return 1
    fi

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

    if [ $? -eq 0 ]; then
        show_success "Playlist downloaded successfully"
    else
        show_error "Failed to download playlist"
    fi

    press_any_key
}

# Download video in best quality
download_best_quality() {
    if ! check_ytdlp_installed; then
        return 1
    fi

    local video_url=""

    show_info "Enter video URL:"
    read -r video_url

    if [ -z "$video_url" ]; then
        show_error "URL cannot be empty"
        press_any_key
        return 1
    fi

    show_success "Downloading video in best quality..."
    yt-dlp -f "bestvideo+bestaudio/best" "$video_url"

    if [ $? -eq 0 ]; then
        show_success "Video downloaded successfully"
    else
        show_error "Failed to download video"
    fi

    press_any_key
}

# Download audio only
download_audio_only() {
    if ! check_ytdlp_installed; then
        return 1
    fi

    local video_url=""
    local audio_format=""

    show_info "Enter video URL:"
    read -r video_url

    if [ -z "$video_url" ]; then
        show_error "URL cannot be empty"
        press_any_key
        return 1
    fi

    show_info "Select audio format:"
    echo "1) MP3"
    echo "2) M4A (usually better quality)"
    echo "3) WAV (lossless, large file)"
    echo "4) FLAC (lossless, compressed)"
    read -r format_choice

    case $format_choice in
        1) audio_format="mp3" ;;
        2) audio_format="m4a" ;;
        3) audio_format="wav" ;;
        4) audio_format="flac" ;;
        *) audio_format="mp3" ;;
    esac

    show_success "Downloading audio in $audio_format format..."
    yt-dlp -x --audio-format "$audio_format" --audio-quality 0 "$video_url"

    if [ $? -eq 0 ]; then
        show_success "Audio downloaded successfully"
    else
        show_error "Failed to download audio"
    fi

    press_any_key
}

# Show available formats
show_formats() {
    if ! check_ytdlp_installed; then
        return 1
    fi

    local video_url=""

    show_info "Enter video URL:"
    read -r video_url

    if [ -z "$video_url" ]; then
        show_error "URL cannot be empty"
        press_any_key
        return 1
    fi

    show_success "Available formats:"
    yt-dlp -F "$video_url"

    press_any_key
}

# Download with custom format
download_custom_quality() {
    if ! check_ytdlp_installed; then
        return 1
    fi

    local video_url=""
    local format_code=""

    show_info "Enter video URL:"
    read -r video_url

    if [ -z "$video_url" ]; then
        show_error "URL cannot be empty"
        press_any_key
        return 1
    fi

    show_success "Available formats:"
    yt-dlp -F "$video_url"

    show_info "Enter format code (e.g., 137+140, 22, bestvideo+bestaudio):"
    read -r format_code

    if [ -z "$format_code" ]; then
        show_error "Format code cannot be empty"
        press_any_key
        return 1
    fi

    show_success "Downloading with format code $format_code..."
    yt-dlp -f "$format_code" "$video_url"

    if [ $? -eq 0 ]; then
        show_success "Video downloaded successfully"
    else
        show_error "Failed to download video"
    fi

    press_any_key
}