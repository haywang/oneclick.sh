# Git operations functions

# Clean Git cache
clean_git_cache() {
    if [ ! -d ".git" ]; then
        echo -e "${RED}Error: Not a Git repository!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}Cleaning Git cache...${NC}"
    git gc --prune=now
    git clean -fd
    echo -e "${GREEN}Git cache cleaned successfully!${NC}"
    sleep 2
}

# Show Git status
show_git_status() {
    if [ ! -d ".git" ]; then
        echo -e "${RED}Error: Not a Git repository!${NC}"
        sleep 2
        return 1
    fi

    git status
    echo -e "\nPress Enter to continue..."
    read -r
}

# Add all changes to Git
git_add_all() {
    if [ ! -d ".git" ]; then
        echo -e "${RED}Error: Not a Git repository!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${YELLOW}Adding all changes to Git...${NC}"
    git add .
    echo -e "${GREEN}All changes have been added!${NC}"
    sleep 2
}

# Commit changes
git_commit() {
    if [ ! -d ".git" ]; then
        echo -e "${RED}Error: Not a Git repository!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Enter commit message: ${NC}"
    read -r commit_message

    if [ -z "$commit_message" ]; then
        echo -e "${RED}Error: Commit message cannot be empty!${NC}"
        sleep 2
        return 1
    fi

    git commit -m "$commit_message"
    echo -e "${GREEN}Changes committed successfully!${NC}"
    sleep 2
}

# Push to remote repository
git_push() {
    if [ ! -d ".git" ]; then
        echo -e "${RED}Error: Not a Git repository!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Enter branch name (default: current branch): ${NC}"
    read -r branch_name

    if [ -z "$branch_name" ]; then
        branch_name=$(git symbolic-ref --short HEAD)
    fi

    echo -e "${YELLOW}Pushing changes to remote repository...${NC}"
    if git push origin "$branch_name"; then
        echo -e "${GREEN}Changes pushed successfully!${NC}"
    else
        echo -e "${RED}Failed to push changes!${NC}"
    fi
    sleep 2
}

# Pull from remote repository
git_pull() {
    if [ ! -d ".git" ]; then
        echo -e "${RED}Error: Not a Git repository!${NC}"
        sleep 2
        return 1
    fi

    echo -e "${CYAN}Enter branch name (default: current branch): ${NC}"
    read -r branch_name

    if [ -z "$branch_name" ]; then
        branch_name=$(git symbolic-ref --short HEAD)
    fi

    echo -e "${YELLOW}Pulling changes from remote repository...${NC}"
    if git pull origin "$branch_name"; then
        echo -e "${GREEN}Changes pulled successfully!${NC}"
    else
        echo -e "${RED}Failed to pull changes!${NC}"
    fi
    sleep 2
}

# Show Git log
show_git_log() {
    if [ ! -d ".git" ]; then
        echo -e "${RED}Error: Not a Git repository!${NC}"
        sleep 2
        return 1
    fi

    git log --oneline --graph --decorate --all
    echo -e "\nPress Enter to continue..."
    read -r
}