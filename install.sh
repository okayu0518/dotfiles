#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止

# キーボード設定
setup_keyboard() {
    echo "Setting up keyboard (capslock to ctrl)..."
    grep -qxF 'setxkbmap -option ctrl:nocaps' ~/.xprofile 2>/dev/null || echo 'setxkbmap -option ctrl:nocaps' >> ~/.xprofile
    gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" 2>/dev/null || true
}

# パッケージインストール
install_packages() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    else
        echo "Unsupported OS"
        exit 1
    fi

    case "$OS" in
        ubuntu|debian|linuxmint)
            echo "Installing packages for Debian/Ubuntu..."
            sudo apt update
            sudo apt install -y vim-gtk3 git gh curl wget build-essential unzip \
                nodejs npm tmux tree ripgrep fzf fd-find xsel htop python3-dev \
                python3-pip python3-venv cmatrix
            ;;
        fedora|rhel|centos|rocky|almalinux)
            echo "Installing packages for Red Hat based distro..."
            sudo dnf update -y
            sudo dnf install -y vim-enhanced git gh curl wget unzip nodejs npm \
                tmux tree ripgrep fzf fd-find xsel htop cmatrix python3-devel \
                python3-pip python3-virtualenv
            ;;
        *)
            echo "Unsupported OS: $OS"
            exit 1
            ;;
    esac
}

# 設定ファイル同期
sync_configs() {
    echo "Syncing configuration files..."
    # Dotfiles
    for file in .bashrc .vimrc .gitconfig .tmux.conf .Xmodmap; do
        ln -sf "$HOME/dotfiles/$file" "$HOME/$file"
    done
    # Byobu
    mkdir -p "$HOME/.byobu"
    ln -sf "$HOME/dotfiles/.tmux.conf" "$HOME/.byobu/.tmux.conf"
    # Neovim
    mkdir -p "$HOME/.config"
    rm -rf "$HOME/.config/nvim"
    ln -sf "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
    # Alacritty
    mkdir -p "$HOME/.config/alacritty"
    ln -sf "$HOME/dotfiles/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
		# wezterm
		mkdir -p "$HOME/.config/wezterm"
		ln -sf "$HOME/dotfiles/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
		echo "Configuration files synced!"
}

# フォントインストール
install_fonts() {
    echo "Installing Hack Nerd Font..."
    FONT_DIR="$HOME/.local/share/fonts"
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
    TEMP_DIR="/tmp/hack-nerd-font"

    mkdir -p "$FONT_DIR" "$TEMP_DIR"
    wget -q "$FONT_URL" -O "$TEMP_DIR/Hack.zip"
    unzip -q "$TEMP_DIR/Hack.zip" -d "$TEMP_DIR"
    find "$TEMP_DIR" -name '*.ttf' -exec cp {} "$FONT_DIR/" \;
    fc-cache -fv
    rm -rf "$TEMP_DIR"
    echo "Font installation completed!"
}

# ネットワーク設定
setup_network() {
    # kut wifi優先度設定（エラーは無視）
    sudo nmcli connection modify "kut" connection.autoconnect-priority -1 2>/dev/null || true
}

# メイン実行
main() {
    setup_keyboard
    install_packages
    sync_configs
    install_fonts
    setup_network
    echo "Setup completed! Please restart your terminal session."
}

main "$@"
