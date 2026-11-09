#!/bin/sh

# Install dir safe to change to whatever you want
install_dir="$HOME/.local/homebrew"


if [ ! -d "$install_dir" ]; then
    echo "Installing Homebrew to $install_dir..."
    mkdir -p "$install_dir"

    curl -L https://github.com/Homebrew/brew/tarball/main | tar xz --strip-components 1 -C "$install_dir"

		brew_bin="$install_dir/bin/brew"
		eval_cmd="eval \"\$($brew_bin shellenv)\""
		fish_cmd="eval \"$brew_bin shellenv\" | source"

    if [ -f "$HOME/.bashrc" ]; then
        if ! grep -qF "$eval_cmd" "$HOME/.bashrc"; then
            echo "$eval_cmd" >> "$HOME/.bashrc"
            echo "Added Homebrew to .bashrc"
        fi
    fi

    if [ -f "$HOME/.zshrc" ]; then
        if ! grep -qF "$eval_cmd" "$HOME/.zshrc"; then
            echo "$eval_cmd" >> "$HOME/.zshrc"
            echo "Added Homebrew to .zshrc"
        fi
    fi

		if [ -f "$HOME/.config/fish/config.fish" ]; then
        if ! grep -qF "$fish_cmd" "$HOME/.config/fish/config.fish"; then
            echo "$fish_cmd" >> "$HOME/.config/fish/config.fish"
            echo "Added Homebrew to config.fish"
        fi
    fi

    echo "Installation complete. Please restart your shell or run 'source ~/.bashrc' (or equivalent)."
else
    echo "Installation aborted."
    echo "Homebrew already exists at $install_dir"
fi 
