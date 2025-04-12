# oneclick.sh

A comprehensive shell script that provides one-click solutions for common system management, software installation, and operations tasks.

## Features

- User Management (add/delete users)
- Software Installation (Git, ZSH, Node.js, PM2, Nginx, etc.)
- UFW Firewall Management
- File Transfer Operations (rsync, scp)
- Video Download with yt-dlp
- Git Operations
- System Monitoring
- Port Management
- And more...

## Installation

### Option 1: One-line Installation (Recommended)

```bash
curl -sL https://raw.githubusercontent.com/haywang/oneclick.sh/main/install.sh | bash
```

This will download and install the latest release of oneclick.sh to `~/.oneclick` and create a symbolic link in `~/bin`.

### Option 2: Manual Installation

```bash
# Clone the repository
git clone https://github.com/haywang/oneclick.sh.git
cd oneclick.sh

# Or build manually and run
./build.sh
./dist/oneclick.sh
```

## Usage

After installation, you can run oneclick.sh simply by typing:

```bash
oneclick
```

This will display the main menu where you can select various options.

## Development

If you're developing or modifying the script:

1. Make your changes in the `src/` directory
2. Use the `./watch.sh` wrapper script to test your changes (it will automatically rebuild when source files change)
3. Or manually rebuild with `./build.sh`
4. The compiled script will be available at `dist/oneclick.sh`

## Release Process

To create a new release:

1. Push a new tag with the version number:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
2. GitHub Actions will automatically build and create a release

## License

MIT
