#!/bin/bash

# Function to display File Transfer submenu
show_file_transfer_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}          FILE TRANSFER               ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. SSH Connection${NC}"
    echo -e "${GREEN}2. SCP Transfer${NC}"
    echo -e "${GREEN}3. Rsync Tools${NC}"
    echo -e "${YELLOW}0. Back to main menu${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Function to display SCP menu
show_scp_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}          SCP TRANSFER                ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Copy file to remote${NC}"
    echo -e "${GREEN}2. Copy file from remote${NC}"
    echo -e "${GREEN}3. Copy directory to remote${NC}"
    echo -e "${GREEN}4. Copy directory from remote${NC}"
    echo -e "${GREEN}5. Copy multiple files${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Function to display Rsync menu
show_rsync_menu() {
    clear
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${BOLD_GREEN}          RSYNC TOOLS                 ${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${GREEN}1. Sync local to remote${NC}"
    echo -e "${GREEN}2. Sync remote to local${NC}"
    echo -e "${GREEN}3. Sync local directory${NC}"
    echo -e "${GREEN}4. Backup with timestamp${NC}"
    echo -e "${YELLOW}0. Back${NC}"
    echo -e "${BOLD_GREEN}========================================${NC}"
    echo -e "${CYAN}Please enter your choice: ${NC}"
}

# Function for SSH connection
ssh_tool() {
    clear
    echo -e "${BOLD_GREEN}SSH Tool${NC}"
    echo -e "${CYAN}Enter server address (user@hostname): ${NC}"
    read server

    # Check if server is provided
    if [ -z "$server" ]; then
        echo -e "${BOLD_RED}Server address cannot be empty. Please try again.${NC}"
        sleep 2
        return
    fi

    # Connect to server
    ssh $server

    echo -e "${CYAN}SSH session ended. Press any key to continue...${NC}"
    read -n 1
}

# Function for SCP operations
scp_tools() {
    local choice

    while true; do
        show_scp_menu
        read choice

        case $choice in
            1) scp_file_to_remote ;;
            2) scp_file_from_remote ;;
            3) scp_directory_to_remote ;;
            4) scp_directory_from_remote ;;
            5) scp_multiple_files ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Function for copying single file to remote
scp_file_to_remote() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy File to Remote${NC}"
    echo -e "${CYAN}Enter local file path: ${NC}"
    read local_path

    if [ ! -f "$local_path" ]; then
        echo -e "${BOLD_RED}Error: File does not exist.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Enter remote destination (user@host:path): ${NC}"
    read remote_path

    if [ -z "$local_path" ] || [ -z "$remote_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Copying file...${NC}"
    scp -p "$local_path" "$remote_path"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}File copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for copying single file from remote
scp_file_from_remote() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy File from Remote${NC}"
    echo -e "${CYAN}Enter remote file path (user@host:path): ${NC}"
    read remote_path
    echo -e "${CYAN}Enter local destination path: ${NC}"
    read local_path

    if [ -z "$remote_path" ] || [ -z "$local_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Copying file...${NC}"
    scp -p "$remote_path" "$local_path"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}File copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for copying directory to remote
scp_directory_to_remote() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy Directory to Remote${NC}"
    echo -e "${CYAN}Enter local directory path: ${NC}"
    read local_path

    if [ ! -d "$local_path" ]; then
        echo -e "${BOLD_RED}Error: Directory does not exist.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Enter remote destination (user@host:path): ${NC}"
    read remote_path

    if [ -z "$local_path" ] || [ -z "$remote_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select copy options:${NC}"
    echo -e "${GREEN}1. Copy directory contents${NC}"
    echo -e "${GREEN}2. Copy directory itself${NC}"
    read -r copy_option

    echo -e "${CYAN}Copying directory...${NC}"
    case $copy_option in
        1)
            scp -rp "$local_path"/* "$remote_path"
            ;;
        2)
            scp -rp "$local_path" "$remote_path"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using default (copy directory itself)${NC}"
            scp -rp "$local_path" "$remote_path"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Directory copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for copying directory from remote
scp_directory_from_remote() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy Directory from Remote${NC}"
    echo -e "${CYAN}Enter remote directory path (user@host:path): ${NC}"
    read remote_path
    echo -e "${CYAN}Enter local destination path: ${NC}"
    read local_path

    if [ -z "$remote_path" ] || [ -z "$local_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select copy options:${NC}"
    echo -e "${GREEN}1. Copy directory contents${NC}"
    echo -e "${GREEN}2. Copy directory itself${NC}"
    read -r copy_option

    echo -e "${CYAN}Copying directory...${NC}"
    case $copy_option in
        1)
            mkdir -p "$local_path"
            scp -rp "$remote_path"/* "$local_path"
            ;;
        2)
            scp -rp "$remote_path" "$local_path"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using default (copy directory itself)${NC}"
            scp -rp "$remote_path" "$local_path"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Directory copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for copying multiple files
scp_multiple_files() {
    clear
    echo -e "${BOLD_GREEN}SCP: Copy Multiple Files${NC}"
    echo -e "${CYAN}Enter source path (local or remote): ${NC}"
    read source_path
    echo -e "${CYAN}Enter destination path (local or remote): ${NC}"
    read dest_path
    echo -e "${CYAN}Enter file patterns (space-separated, e.g., '*.txt *.pdf'): ${NC}"
    read file_patterns

    if [ -z "$source_path" ] || [ -z "$dest_path" ] || [ -z "$file_patterns" ]; then
        echo -e "${BOLD_RED}All fields must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Copying files...${NC}"
    for pattern in $file_patterns; do
        scp -p "$source_path/$pattern" "$dest_path/"
    done

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Files copied successfully.${NC}"
    else
        echo -e "${BOLD_RED}Copy failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to handle rsync operations
rsync_tools() {
    local choice

    while true; do
        show_rsync_menu
        read choice

        case $choice in
            1) rsync_local_to_remote ;;
            2) rsync_remote_to_local ;;
            3) rsync_local_directory ;;
            4) rsync_backup_timestamp ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}

# Function for rsync local to remote
rsync_local_to_remote() {
    clear
    echo -e "${BOLD_GREEN}Rsync: Local to Remote${NC}"
    echo -e "${CYAN}Enter local source path: ${NC}"
    read local_path
    echo -e "${CYAN}Enter remote destination (user@host:path): ${NC}"
    read remote_path

    if [ -z "$local_path" ] || [ -z "$remote_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select sync options:${NC}"
    echo -e "${GREEN}1. Simple sync (no delete)${NC}"
    echo -e "${GREEN}2. Mirror (with delete)${NC}"
    echo -e "${GREEN}3. Dry run (test only)${NC}"
    read -r sync_option

    local rsync_opts="-avzh --progress"
    case $sync_option in
        1)
            echo -e "${CYAN}Performing simple sync...${NC}"
            ;;
        2)
            echo -e "${YELLOW}Warning: Mirror mode will delete files in destination that don't exist in source${NC}"
            echo -e "${CYAN}Continue? (y/N): ${NC}"
            read -r confirm
            if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
                echo -e "${CYAN}Operation cancelled.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return
            fi
            rsync_opts="$rsync_opts --delete"
            ;;
        3)
            rsync_opts="$rsync_opts --dry-run"
            echo -e "${CYAN}Performing dry run (no actual changes)...${NC}"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using simple sync.${NC}"
            ;;
    esac

    echo -e "${CYAN}Syncing files...${NC}"
    rsync $rsync_opts "$local_path" "$remote_path"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Sync completed successfully.${NC}"
    else
        echo -e "${BOLD_RED}Sync failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for rsync remote to local
rsync_remote_to_local() {
    clear
    echo -e "${BOLD_GREEN}Rsync: Remote to Local${NC}"
    echo -e "${CYAN}Enter remote source (user@host:path): ${NC}"
    read remote_path
    echo -e "${CYAN}Enter local destination path: ${NC}"
    read local_path

    if [ -z "$remote_path" ] || [ -z "$local_path" ]; then
        echo -e "${BOLD_RED}Both paths must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select sync options:${NC}"
    echo -e "${GREEN}1. Simple sync (no delete)${NC}"
    echo -e "${GREEN}2. Mirror (with delete)${NC}"
    echo -e "${GREEN}3. Dry run (test only)${NC}"
    read -r sync_option

    local rsync_opts="-avzh --progress"
    case $sync_option in
        1)
            echo -e "${CYAN}Performing simple sync...${NC}"
            ;;
        2)
            echo -e "${YELLOW}Warning: Mirror mode will delete files in destination that don't exist in source${NC}"
            echo -e "${CYAN}Continue? (y/N): ${NC}"
            read -r confirm
            if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
                echo -e "${CYAN}Operation cancelled.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return
            fi
            rsync_opts="$rsync_opts --delete"
            ;;
        3)
            rsync_opts="$rsync_opts --dry-run"
            echo -e "${CYAN}Performing dry run (no actual changes)...${NC}"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using simple sync.${NC}"
            ;;
    esac

    echo -e "${CYAN}Syncing files...${NC}"
    rsync $rsync_opts "$remote_path" "$local_path"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Sync completed successfully.${NC}"
    else
        echo -e "${BOLD_RED}Sync failed. Please check the paths and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for rsync local directory
rsync_local_directory() {
    clear
    echo -e "${BOLD_GREEN}Rsync: Local Directory Sync${NC}"
    echo -e "${CYAN}Enter source directory: ${NC}"
    read source_dir
    echo -e "${CYAN}Enter destination directory: ${NC}"
    read dest_dir

    if [ -z "$source_dir" ] || [ -z "$dest_dir" ]; then
        echo -e "${BOLD_RED}Both directories must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Select sync options:${NC}"
    echo -e "${GREEN}1. Simple sync (no delete)${NC}"
    echo -e "${GREEN}2. Mirror (with delete)${NC}"
    echo -e "${GREEN}3. Dry run (test only)${NC}"
    read -r sync_option

    local rsync_opts="-avzh --progress"
    case $sync_option in
        1)
            echo -e "${CYAN}Performing simple sync...${NC}"
            ;;
        2)
            echo -e "${YELLOW}Warning: Mirror mode will delete files in destination that don't exist in source${NC}"
            echo -e "${CYAN}Continue? (y/N): ${NC}"
            read -r confirm
            if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
                echo -e "${CYAN}Operation cancelled.${NC}"
                echo -e "${CYAN}Press any key to continue...${NC}"
                read -n 1
                return
            fi
            rsync_opts="$rsync_opts --delete"
            ;;
        3)
            rsync_opts="$rsync_opts --dry-run"
            echo -e "${CYAN}Performing dry run (no actual changes)...${NC}"
            ;;
        *)
            echo -e "${BOLD_RED}Invalid option. Using simple sync.${NC}"
            ;;
    esac

    echo -e "${CYAN}Syncing directories...${NC}"
    rsync $rsync_opts "$source_dir/" "$dest_dir/"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Sync completed successfully.${NC}"
    else
        echo -e "${BOLD_RED}Sync failed. Please check the directories and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function for rsync backup with timestamp
rsync_backup_timestamp() {
    clear
    echo -e "${BOLD_GREEN}Rsync: Backup with Timestamp${NC}"
    echo -e "${CYAN}Enter source directory: ${NC}"
    read source_dir
    echo -e "${CYAN}Enter backup base directory: ${NC}"
    read backup_base

    if [ -z "$source_dir" ] || [ -z "$backup_base" ]; then
        echo -e "${BOLD_RED}Both directories must be provided.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Create timestamp
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="${backup_base}/backup_${timestamp}"

    echo -e "${CYAN}Backup will be created in: ${backup_dir}${NC}"
    echo -e "${CYAN}Continue? (Y/n): ${NC}"
    read -r confirm
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
        echo -e "${CYAN}Operation cancelled.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return
    fi

    # Create backup directory if it doesn't exist
    mkdir -p "$backup_dir"

    echo -e "${CYAN}Creating backup...${NC}"
    rsync -avzh --progress "$source_dir/" "$backup_dir/"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Backup completed successfully.${NC}"
        echo -e "${GREEN}Backup location: ${backup_dir}${NC}"
    else
        echo -e "${BOLD_RED}Backup failed. Please check the directories and try again.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# File Transfer menu handler
file_transfer_menu() {
    local choice

    while true; do
        show_file_transfer_menu
        read choice

        case $choice in
            1) ssh_tool ;;
            2) scp_tools ;;
            3) rsync_tools ;;
            0) break ;;
            *) echo -e "${BOLD_RED}Invalid option. Please try again.${NC}" ; sleep 2 ;;
        esac
    done
}
