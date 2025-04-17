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

# Either run the wrapper script (it will build automatically if needed)
./oneclick

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

To check the version of oneclick.sh:

```bash
oneclick --version
```

## Development

If you're developing or modifying the script:

1. Make your changes in the `src/` directory
2. Use the `./watch.sh` wrapper script to test your changes (it will automatically rebuild when source files change)
3. Or manually rebuild with `./build.sh`
4. The compiled script will be available at `dist/oneclick.sh`

## Version Management

To update the version number of oneclick.sh, use the provided version management script:

```bash
./bump_version.sh
```

### Using bump_version.sh

The `bump_version.sh` script helps manage version numbers for releases:

1. **Running the script**: Execute `./bump_version.sh` in the project root
2. **Version input**:
   - Enter a specific version number when prompted
   - Or press Enter to automatically increment the patch version (e.g., 1.0.0 → 1.0.1)
3. **What it does**:
   - Updates the VERSION variable in `build.sh`
   - Commits the change to git
   - Creates a git tag for the new version
4. **Pushing changes**:
   - After running the script, you'll need to push the changes:
   ```bash
   git push && git push --tags
   ```
   - This will trigger GitHub Actions to create a new release

### Notes on Version Numbers

- Uses semantic versioning (MAJOR.MINOR.PATCH)
- The version number is embedded in the built script
- Users can check the version with `oneclick --version`

## Release Process

To create a new release:

1. Update the version using the bump script:
   ```bash
   ./bump_version.sh
   ```
2. Push the changes and tags:
   ```bash
   git push && git push --tags
   ```
3. GitHub Actions will automatically build and create a release

## License

MIT
