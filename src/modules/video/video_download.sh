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
                show_warning "Failed to install yt-dlp with Homebrew. Trying alternative methods..."
            fi
        else
            show_warning "Homebrew not found. Trying alternative methods..."
        fi

        # 尝试使用系统包管理器安装
        if command_exists apt-get; then
            show_success "Trying to install yt-dlp with apt..."
            sudo apt update && sudo apt install -y python3-pip python3-yt-dlp

            if command_exists yt-dlp; then
                show_success "yt-dlp installed successfully with apt to version:"
                yt-dlp --version
                press_any_key
                return 0
            else
                show_warning "yt-dlp not available in apt repositories or installation failed. Trying pip3..."
            fi
        fi

        # 如果系统包管理器安装失败，尝试pip3安装
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
                    sudo apt-get install -y python3-full python3-pip
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

        # 尝试使用pip3安装
        show_success "Installing yt-dlp with pip3..."
        pip3 install yt-dlp

        # 检查是否安装失败
        if ! command_exists yt-dlp; then
            show_warning "Standard pip3 installation failed. Attempting alternative methods..."

            # 提示用户选择安装方法
            echo -e "${CYAN}Select an installation method:${NC}"
            echo "1) Try installing with --break-system-packages flag (may affect system stability)"
            echo "2) Install using pipx (recommended for Python applications)"
            echo "3) Create a virtual environment and install there"
            echo "4) Cancel installation"
            read -r install_choice

            case $install_choice in
                1)
                    show_success "Installing with --break-system-packages flag..."
                    pip3 install --break-system-packages yt-dlp
                    ;;
                2)
                    # 检查pipx是否存在，不存在则安装
                    if ! command_exists pipx; then
                        show_success "Installing pipx first..."
                        if command_exists apt-get; then
                            sudo apt-get install -y pipx
                        else
                            pip3 install --user pipx
                            python3 -m pipx ensurepath
                        fi
                    fi

                    # 使用pipx安装yt-dlp
                    show_success "Installing yt-dlp with pipx..."
                    pipx install yt-dlp
                    ;;
                3)
                    # 创建虚拟环境
                    show_success "Creating virtual environment for yt-dlp..."
                    mkdir -p ~/.venv
                    python3 -m venv ~/.venv/yt-dlp

                    # 在虚拟环境中安装yt-dlp
                    show_success "Installing yt-dlp in virtual environment..."
                    ~/.venv/yt-dlp/bin/pip install yt-dlp

                    # 创建符号链接到PATH
                    show_success "Creating symbolic link to make yt-dlp available in PATH..."
                    mkdir -p ~/bin
                    ln -sf ~/.venv/yt-dlp/bin/yt-dlp ~/bin/yt-dlp

                    # 检查~/bin是否在PATH中
                    if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
                        echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
                        echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
                        export PATH="$HOME/bin:$PATH"
                    fi
                    ;;
                4)
                    show_warning "Installation cancelled."
                    press_any_key
                    return 1
                    ;;
                *)
                    show_error "Invalid option. Installation cancelled."
                    press_any_key
                    return 1
                    ;;
            esac
        fi

        # 最终检查是否安装成功
        if command_exists yt-dlp; then
            show_success "yt-dlp installed successfully to version:"
            yt-dlp --version
        else
            show_error "Failed to install yt-dlp. Please try another installation method."
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
        local installation_method=""

        # 确定yt-dlp的安装方式
        if command_exists brew && brew list | grep -q yt-dlp; then
            installation_method="brew"
        elif [[ -f ~/.venv/yt-dlp/bin/yt-dlp && -L ~/bin/yt-dlp && ~/bin/yt-dlp -ef ~/.venv/yt-dlp/bin/yt-dlp ]]; then
            installation_method="venv"
        elif command_exists pipx && pipx list | grep -q yt-dlp; then
            installation_method="pipx"
        elif command_exists apt-get && dpkg -l | grep -q python3-yt-dlp; then
            installation_method="apt"
        else
            installation_method="pip"
        fi

        # 根据安装方式检查更新
        case $installation_method in
            brew)
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
                ;;
            venv)
                # 使用虚拟环境pip检查更新
                ~/.venv/yt-dlp/bin/pip list --outdated | grep yt-dlp
                if [ $? -ne 0 ]; then
                    show_warning "Already the latest version. No update needed."
                    press_any_key
                    return 0
                else
                    show_success "New version available."
                    has_update=true
                fi
                ;;
            pipx)
                # 使用pipx检查更新
                show_success "Checking pipx for updates..."
                pipx upgrade yt-dlp
                press_any_key
                return 0
                ;;
            apt)
                # 使用apt检查更新
                apt list --upgradable | grep python3-yt-dlp
                if [ $? -ne 0 ]; then
                    show_warning "Already the latest version. No update needed."
                    press_any_key
                    return 0
                else
                    show_success "New version available."
                    has_update=true
                fi
                ;;
            pip)
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
                ;;
        esac

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
            case $installation_method in
                brew)
                    # 通过Homebrew更新
                    show_success "Updating yt-dlp with Homebrew..."
                    brew upgrade yt-dlp
                    ;;
                venv)
                    # 通过虚拟环境pip更新
                    show_success "Updating yt-dlp in virtual environment..."
                    ~/.venv/yt-dlp/bin/pip install --upgrade yt-dlp
                    ;;
                apt)
                    # 通过apt更新
                    show_success "Updating yt-dlp with apt..."
                    sudo apt update && sudo apt install --only-upgrade -y python3-yt-dlp
                    ;;
                pip)
                    # 询问用户如何处理pip更新
                    show_info "Pip installation in an externally managed environment may fail. Choose an update method:"
                    echo "1) Try updating with --break-system-packages flag (may affect system stability)"
                    echo "2) Reinstall using pipx (recommended for Python applications)"
                    echo "3) Reinstall in a virtual environment"
                    echo "4) Cancel update"
                    read -r update_pip_choice

                    case $update_pip_choice in
                        1)
                            show_success "Updating with --break-system-packages flag..."
                            pip3 install --upgrade --break-system-packages yt-dlp
                            ;;
                        2)
                            # 检查pipx是否存在，不存在则安装
                            if ! command_exists pipx; then
                                show_success "Installing pipx first..."
                                if command_exists apt-get; then
                                    sudo apt-get install -y pipx
                                else
                                    pip3 install --user pipx
                                    python3 -m pipx ensurepath
                                fi
                            fi

                            # 使用pipx安装yt-dlp
                            show_success "Installing yt-dlp with pipx..."
                            pipx install yt-dlp --force
                            ;;
                        3)
                            # 创建虚拟环境
                            show_success "Creating virtual environment for yt-dlp..."
                            mkdir -p ~/.venv
                            python3 -m venv ~/.venv/yt-dlp

                            # 在虚拟环境中安装yt-dlp
                            show_success "Installing yt-dlp in virtual environment..."
                            ~/.venv/yt-dlp/bin/pip install yt-dlp

                            # 创建符号链接到PATH
                            show_success "Creating symbolic link to make yt-dlp available in PATH..."
                            mkdir -p ~/bin
                            ln -sf ~/.venv/yt-dlp/bin/yt-dlp ~/bin/yt-dlp

                            # 检查~/bin是否在PATH中
                            if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
                                echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
                                echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
                                export PATH="$HOME/bin:$PATH"
                            fi
                            ;;
                        4)
                            show_warning "Update cancelled."
                            press_any_key
                            return 0
                            ;;
                        *)
                            show_error "Invalid option. Update cancelled."
                            press_any_key
                            return 0
                            ;;
                    esac
                    ;;
            esac

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