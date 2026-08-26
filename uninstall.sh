#!/bin/sh

# Define the installation directory (Must match your install script)
install_dir="$HOME/.local/homebrew"

echo "==> Starting Homebrew uninstallation..."

# 1. Remove the Homebrew directory and cache
if [ -d "$install_dir" ]; then
    echo "==> Removing $install_dir"
    rm -rf "$install_dir"
    
    # Remove common cache/log locations if they exist inside .local
    rm -rf "$HOME/.local/Caches/Homebrew"
    rm -rf "$HOME/.local/Logs/Homebrew"
    
    echo "==> Homebrew directory removed."
else
    echo "==> Directory $install_dir not found. Skipping file removal."
fi

# 2. Clean Shell Configuration Files
# We define the exact lines added by the install script to remove them precisely.
# Using sed -i requires different flags for macOS vs Linux. 
# This script uses a portable method: grep to check, then sed to create a temp file and move it.

clean_file() {
    file="$1"
    pattern="$2"
    
    if [ -f "$file" ]; then
        if grep -qF "$pattern" "$file"; then
            echo "==> Cleaning $file"
            # Create a temp file without the pattern, then overwrite original
            # -F treats the pattern as a fixed string (safer for code with special chars)
            grep -vF "$pattern" "$file" > "$file.tmp" && mv "$file.tmp" "$file"
        else
            echo "==> No Homebrew entry found in $file"
        fi
    fi
}

# Define the exact strings to remove (Must match your install script exactly)
bash_zsh_pattern='eval "$HOME/.local/homebrew/bin/brew shellenv"'
fish_pattern='eval "$HOME/.local/homebrew/bin/brew shellenv"'

# Clean Bash
clean_file "$HOME/.bashrc" "$bash_zsh_pattern"

# Clean Zsh
clean_file "$HOME/.zshrc" "$bash_zsh_pattern"

# Clean Fish
clean_file "$HOME/.config/fish/config.fish" "$fish_pattern"

echo ""
echo "==> Uninstallation complete."
echo "==> Please restart your terminal or run 'source ~/.bashrc' (or equivalent) to apply changes."   
