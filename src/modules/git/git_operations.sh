#!/bin/bash

# Function to remove cached directory from git
git_rm_cached_directory() {
    clear
    echo -e "${BOLD_GREEN}Git Remove Cached Directory${NC}"

    # Check if current directory is a git repository
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e "${BOLD_RED}Error: Current directory is not a git repository.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Enter directory name to remove from git cache: ${NC}"
    read dir_name

    # Check if directory name is provided
    if [ -z "$dir_name" ]; then
        echo -e "${BOLD_RED}Directory name cannot be empty. Please try again.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    # Check if directory exists
    if [ ! -d "$dir_name" ]; then
        echo -e "${BOLD_RED}Directory '$dir_name' does not exist.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${YELLOW}Are you sure you want to remove '$dir_name' from git cache? (y/N): ${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        if git rm -r --cached "$dir_name"; then
            echo -e "${GREEN}Successfully removed '$dir_name' from git cache.${NC}"
            echo -e "${YELLOW}Remember to commit this change and push to remote repository.${NC}"
        else
            echo -e "${BOLD_RED}Failed to remove directory from git cache.${NC}"
        fi
    else
        echo -e "${CYAN}Operation cancelled.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to show git status
git_status() {
    clear
    echo -e "${BOLD_GREEN}Git Status${NC}"

    # Check if current directory is a git repository
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e "${BOLD_RED}Error: Current directory is not a git repository.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    git status

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to pull from remote
git_pull() {
    clear
    echo -e "${BOLD_GREEN}Git Pull${NC}"

    # Check if current directory is a git repository
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e "${BOLD_RED}Error: Current directory is not a git repository.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Pulling from remote...${NC}"
    git pull

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to push to remote
git_push() {
    clear
    echo -e "${BOLD_GREEN}Git Push${NC}"

    # Check if current directory is a git repository
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e "${BOLD_RED}Error: Current directory is not a git repository.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Pushing to remote...${NC}"
    git push

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to add all changes
git_add_all() {
    clear
    echo -e "${BOLD_GREEN}Git Add All${NC}"

    # Check if current directory is a git repository
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e "${BOLD_RED}Error: Current directory is not a git repository.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    git add .
    echo -e "${GREEN}All changes have been staged.${NC}"

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to commit changes
git_commit() {
    clear
    echo -e "${BOLD_GREEN}Git Commit${NC}"

    # Check if current directory is a git repository
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e "${BOLD_RED}Error: Current directory is not a git repository.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Enter commit message: ${NC}"
    read -r message

    if [ -z "$message" ]; then
        echo -e "${BOLD_RED}Commit message cannot be empty.${NC}"
    else
        git commit -m "$message"
        echo -e "${GREEN}Changes have been committed.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to set git HTTP and HTTPS proxy
git_set_proxy() {
    clear
    echo -e "${BOLD_GREEN}Git Proxy Settings${NC}"

    # Check if git is installed
    if ! command -v git &> /dev/null; then
        echo -e "${BOLD_RED}Error: Git is not installed.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Current proxy settings:${NC}"
    local current_http=$(git config --global --get http.proxy)
    local current_https=$(git config --global --get https.proxy)

    if [ -n "$current_http" ]; then
        echo -e "HTTP proxy: ${GREEN}$current_http${NC}"
    else
        echo -e "HTTP proxy: ${YELLOW}Not set${NC}"
    fi

    if [ -n "$current_https" ]; then
        echo -e "HTTPS proxy: ${GREEN}$current_https${NC}"
    else
        echo -e "HTTPS proxy: ${YELLOW}Not set${NC}"
    fi

    echo
    echo -e "${CYAN}Enter HTTP proxy (format: http://host:port) or leave empty to skip:${NC}"
    read -r http_proxy

    echo -e "${CYAN}Enter HTTPS proxy (format: http://host:port) or leave empty to skip:${NC}"
    read -r https_proxy

    if [ -n "$http_proxy" ]; then
        git config --global http.proxy "$http_proxy"
        echo -e "${GREEN}HTTP proxy has been set to: $http_proxy${NC}"
    fi

    if [ -n "$https_proxy" ]; then
        git config --global https.proxy "$https_proxy"
        echo -e "${GREEN}HTTPS proxy has been set to: $https_proxy${NC}"
    fi

    if [ -z "$http_proxy" ] && [ -z "$https_proxy" ]; then
        echo -e "${YELLOW}No changes were made to proxy settings.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}

# Function to unset git proxy
git_unset_proxy() {
    clear
    echo -e "${BOLD_GREEN}Remove Git Proxy Settings${NC}"

    # Check if git is installed
    if ! command -v git &> /dev/null; then
        echo -e "${BOLD_RED}Error: Git is not installed.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 1
    fi

    echo -e "${CYAN}Current proxy settings:${NC}"
    local current_http=$(git config --global --get http.proxy)
    local current_https=$(git config --global --get https.proxy)

    if [ -n "$current_http" ]; then
        echo -e "HTTP proxy: ${GREEN}$current_http${NC}"
    else
        echo -e "HTTP proxy: ${YELLOW}Not set${NC}"
    fi

    if [ -n "$current_https" ]; then
        echo -e "HTTPS proxy: ${GREEN}$current_https${NC}"
    else
        echo -e "HTTPS proxy: ${YELLOW}Not set${NC}"
    fi

    if [ -z "$current_http" ] && [ -z "$current_https" ]; then
        echo -e "${YELLOW}No proxy settings to remove.${NC}"
        echo -e "${CYAN}Press any key to continue...${NC}"
        read -n 1
        return 0
    fi

    echo
    echo -e "${CYAN}Do you want to remove the git proxy settings? (y/N):${NC}"
    read -r confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        git config --global --unset http.proxy
        git config --global --unset https.proxy
        echo -e "${GREEN}Git proxy settings have been removed.${NC}"
    else
        echo -e "${YELLOW}Operation cancelled.${NC}"
    fi

    echo -e "${CYAN}Press any key to continue...${NC}"
    read -n 1
}