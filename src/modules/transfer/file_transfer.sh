# File transfer functions

# SCP file transfer
scp_transfer() {
    local source_path=""
    local dest_path=""
    local direction=""
    local remote_host=""
    local remote_user=""
    local valid_selection=false

    while ! $valid_selection; do
        show_info "Select transfer direction:"
        echo "1) Upload (Local -> Remote)"
        echo "2) Download (Remote -> Local)"
        read -r direction

        case $direction in
            1|2)
                valid_selection=true
                ;;
            "")
                show_error "No option selected. Please enter 1 or 2."
                sleep 1
                ;;
            *)
                show_error "Invalid option. Please enter 1 or 2."
                sleep 1
                ;;
        esac
    done

    case $direction in
        1)
            show_info "Enter local source file/directory path:"
            read -r source_path

            show_info "Enter remote username:"
            read -r remote_user

            show_info "Enter remote host:"
            read -r remote_host

            show_info "Enter remote destination path:"
            read -r dest_path

            if [ ! -e "$source_path" ]; then
                show_error "Source path does not exist: $source_path"
                return 1
            fi

            show_success "Uploading to remote server..."
            if [ -d "$source_path" ]; then
                scp -r "$source_path" "$remote_user@$remote_host:$dest_path"
            else
                scp "$source_path" "$remote_user@$remote_host:$dest_path"
            fi
            ;;

        2)
            show_info "Enter remote username:"
            read -r remote_user

            show_info "Enter remote host:"
            read -r remote_host

            show_info "Enter remote source file/directory path:"
            read -r source_path

            show_info "Enter local destination path:"
            read -r dest_path

            if [ ! -d "$(dirname "$dest_path")" ]; then
                show_error "Destination directory does not exist: $(dirname "$dest_path")"
                return 1
            fi

            show_success "Downloading from remote server..."
            scp -r "$remote_user@$remote_host:$source_path" "$dest_path"
            ;;
    esac

    if [ $? -eq 0 ]; then
        show_success "Transfer completed successfully"
    else
        show_error "Transfer failed"
        return 1
    fi

    press_any_key
}

# Rsync synchronization
rsync_sync() {
    local source_path=""
    local dest_path=""
    local direction=""
    local remote_host=""
    local remote_user=""
    local options=""
    local valid_dir_selection=false
    local valid_opt_selection=false

    while ! $valid_dir_selection; do
        show_info "Select sync direction:"
        echo "1) Upload (Local -> Remote)"
        echo "2) Download (Remote -> Local)"
        read -r direction

        case $direction in
            1|2)
                valid_dir_selection=true
                ;;
            "")
                show_error "No option selected. Please enter 1 or 2."
                sleep 1
                ;;
            *)
                show_error "Invalid option. Please enter 1 or 2."
                sleep 1
                ;;
        esac
    done

    while ! $valid_opt_selection; do
        show_info "Select sync options:"
        echo "1) Mirror (delete files that don't exist in source)"
        echo "2) Update (only newer files)"
        echo "3) Backup (keep old files)"
        read -r sync_option

        case $sync_option in
            1)
                options="-avz --delete"
                valid_opt_selection=true
                ;;
            2)
                options="-avz --update"
                valid_opt_selection=true
                ;;
            3)
                options="-avz --backup"
                valid_opt_selection=true
                ;;
            "")
                # 默认选项
                options="-avz"
                valid_opt_selection=true
                ;;
            *)
                show_error "Invalid option. Please enter 1, 2, or 3."
                sleep 1
                ;;
        esac
    done

    case $direction in
        1)
            show_info "Enter local source directory path:"
            read -r source_path

            show_info "Enter remote username:"
            read -r remote_user

            show_info "Enter remote host:"
            read -r remote_host

            show_info "Enter remote destination path:"
            read -r dest_path

            if [ ! -d "$source_path" ]; then
                show_error "Source directory does not exist: $source_path"
                return 1
            fi

            show_success "Syncing to remote server..."
            rsync $options "$source_path/" "$remote_user@$remote_host:$dest_path"
            ;;

        2)
            show_info "Enter remote username:"
            read -r remote_user

            show_info "Enter remote host:"
            read -r remote_host

            show_info "Enter remote source directory path:"
            read -r source_path

            show_info "Enter local destination path:"
            read -r dest_path

            if [ ! -d "$dest_path" ]; then
                show_error "Destination directory does not exist: $dest_path"
                return 1
            fi

            show_success "Syncing from remote server..."
            rsync $options "$remote_user@$remote_host:$source_path/" "$dest_path"
            ;;
    esac

    if [ $? -eq 0 ]; then
        show_success "Synchronization completed successfully"
    else
        show_error "Synchronization failed"
        return 1
    fi

    press_any_key
}

# SSH key management
generate_ssh_key() {
    local key_type=""
    local key_name=""
    local key_comment=""
    local valid_selection=false

    while ! $valid_selection; do
        show_info "Select SSH key type:"
        echo "1) RSA (default)"
        echo "2) Ed25519 (more secure)"
        read -r key_type

        case $key_type in
            1|2)
                valid_selection=true
                ;;
            "")
                # 默认选项为RSA
                key_type=1
                valid_selection=true
                ;;
            *)
                show_error "Invalid option. Please enter 1 or 2."
                sleep 1
                ;;
        esac
    done

    show_info "Enter key name (default: id_rsa or id_ed25519):"
    read -r key_name

    show_info "Enter key comment (usually your email):"
    read -r key_comment

    case $key_type in
        2)
            if [ -z "$key_name" ]; then
                key_name="id_ed25519"
            fi
            ssh-keygen -t ed25519 -f "$HOME/.ssh/$key_name" -C "$key_comment"
            ;;
        *)
            if [ -z "$key_name" ]; then
                key_name="id_rsa"
            fi
            ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/$key_name" -C "$key_comment"
            ;;
    esac

    if [ $? -eq 0 ]; then
        show_success "SSH key generated successfully"
        show_info "Your public key is:"
        cat "$HOME/.ssh/$key_name.pub"
    else
        show_error "Failed to generate SSH key"
        return 1
    fi

    press_any_key
}

# Copy SSH key to remote server
copy_ssh_key() {
    local remote_user=""
    local remote_host=""
    local key_path=""

    show_info "Enter remote username:"
    read -r remote_user

    show_info "Enter remote host:"
    read -r remote_host

    show_info "Enter path to public key (default: ~/.ssh/id_rsa.pub):"
    read -r key_path

    if [ -z "$key_path" ]; then
        key_path="$HOME/.ssh/id_rsa.pub"
    fi

    if [ ! -f "$key_path" ]; then
        show_error "Public key file not found: $key_path"
        return 1
    fi

    show_success "Copying SSH key to remote server..."
    ssh-copy-id -i "$key_path" "$remote_user@$remote_host"

    if [ $? -eq 0 ]; then
        show_success "SSH key copied successfully"
    else
        show_error "Failed to copy SSH key"
        return 1
    fi

    press_any_key
}