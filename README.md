# Interactive Shell Menu

This is a green-themed interactive shell menu script that provides server setup, tools, and diagnostic functions.

## Features

### Server Setup
- Add new user and set sudoer privileges
- Install Git
- Install ZSH
- Install Oh-My-ZSH
- Install NVM
- Install Node.js
- Install PM2
- Install Nginx

### Tools
- SSH connection
- Check port usage
- Copy files from local to server (SCP)
- Copy files from server to local (SCP)

### Diagnostics
- Run Top command to monitor system resources

## Usage

1. Make sure the script has execution permissions:
   ```bash
   chmod +x oneclick.sh
   ```

2. Run the script:
   ```bash
   ./oneclick.sh
   ```

3. Use number keys to select menu options

## System Requirements

- Debian/Ubuntu-based Linux system
- Sudo privileges required for certain commands
- Network connection required to install packages

## Notes

- This script is primarily for initial setup of new servers
- Make sure you understand the effect of each command before using in production
- Some operations may require terminal or system restart to take effect
