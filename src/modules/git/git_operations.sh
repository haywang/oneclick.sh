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