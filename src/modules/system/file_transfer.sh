# File transfer functions

# Upload a single file to remote server
upload_file() {
    echo -e "${CYAN}Enter the local file path: ${NC}"
    read -r local_path

    if [ ! -f "$local_path" ]; then
        echo -e "${RED}Error: File not found!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Enter the remote server (user@host): ${NC}"
    read -r remote_server

    echo -e "${CYAN}Enter the remote path: ${NC}"
    read -r remote_path

    echo -e "${YELLOW}Uploading file to remote server...${NC}"
    if scp "$local_path" "$remote_server:$remote_path"; then
        echo -e "${GREEN}File uploaded successfully!${NC}"
    else
        echo -e "${RED}Failed to upload file!${NC}"
    fi
    sleep 2
}

# Download a single file from remote server
download_file() {
    echo -e "${CYAN}Enter the remote server (user@host): ${NC}"
    read -r remote_server

    echo -e "${CYAN}Enter the remote file path: ${NC}"
    read -r remote_path

    echo -e "${CYAN}Enter the local path to save: ${NC}"
    read -r local_path

    echo -e "${YELLOW}Downloading file from remote server...${NC}"
    if scp "$remote_server:$remote_path" "$local_path"; then
        echo -e "${GREEN}File downloaded successfully!${NC}"
    else
        echo -e "${RED}Failed to download file!${NC}"
    fi
    sleep 2
}

# Upload a directory to remote server
upload_directory() {
    echo -e "${CYAN}Enter the local directory path: ${NC}"
    read -r local_path

    if [ ! -d "$local_path" ]; then
        echo -e "${RED}Error: Directory not found!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Enter the remote server (user@host): ${NC}"
    read -r remote_server

    echo -e "${CYAN}Enter the remote path: ${NC}"
    read -r remote_path

    echo -e "${YELLOW}Uploading directory to remote server...${NC}"
    if scp -r "$local_path" "$remote_server:$remote_path"; then
        echo -e "${GREEN}Directory uploaded successfully!${NC}"
    else
        echo -e "${RED}Failed to upload directory!${NC}"
    fi
    sleep 2
}

# Download a directory from remote server
download_directory() {
    echo -e "${CYAN}Enter the remote server (user@host): ${NC}"
    read -r remote_server

    echo -e "${CYAN}Enter the remote directory path: ${NC}"
    read -r remote_path

    echo -e "${CYAN}Enter the local path to save: ${NC}"
    read -r local_path

    echo -e "${YELLOW}Downloading directory from remote server...${NC}"
    if scp -r "$remote_server:$remote_path" "$local_path"; then
        echo -e "${GREEN}Directory downloaded successfully!${NC}"
    else
        echo -e "${RED}Failed to download directory!${NC}"
    fi
    sleep 2
}

# Sync local directory to remote server using rsync
sync_to_remote() {
    echo -e "${CYAN}Enter the local directory path: ${NC}"
    read -r local_path

    if [ ! -d "$local_path" ]; then
        echo -e "${RED}Error: Directory not found!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Enter the remote server (user@host): ${NC}"
    read -r remote_server

    echo -e "${CYAN}Enter the remote path: ${NC}"
    read -r remote_path

    echo -e "${YELLOW}Syncing directory to remote server...${NC}"
    if rsync -avz --progress "$local_path/" "$remote_server:$remote_path"; then
        echo -e "${GREEN}Directory synced successfully!${NC}"
    else
        echo -e "${RED}Failed to sync directory!${NC}"
    fi
    sleep 2
}

# Sync remote directory to local using rsync
sync_from_remote() {
    echo -e "${CYAN}Enter the remote server (user@host): ${NC}"
    read -r remote_server

    echo -e "${CYAN}Enter the remote directory path: ${NC}"
    read -r remote_path

    echo -e "${CYAN}Enter the local path: ${NC}"
    read -r local_path

    if [ ! -d "$local_path" ]; then
        echo -e "${YELLOW}Local directory does not exist. Creating...${NC}"
        mkdir -p "$local_path"
    fi

    echo -e "${YELLOW}Syncing directory from remote server...${NC}"
    if rsync -avz --progress "$remote_server:$remote_path/" "$local_path"; then
        echo -e "${GREEN}Directory synced successfully!${NC}"
    else
        echo -e "${RED}Failed to sync directory!${NC}"
    fi
    sleep 2
}