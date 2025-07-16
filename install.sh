#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止

# 関数定義
setup_keyboard() {
    echo "Setting up keyboard (capslock to ctrl)..."
    echo "setxkbmap -option ctrl:nocaps" >> ~/.xprofile
    gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" 2>/dev/null || true
}

install_packages() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    else
        echo "Unsupported OS"
        exit 1
    fi

    if [[ "$OS" == "ubuntu" || "$OS" == "debian" || "$OS" == "linuxmint" ]]; then
        echo "Installing packages for Debian/Ubuntu..."
        sudo apt update
        sudo apt install -y vim-gtk3 git gh curl wget build-essential unzip \
            nodejs npm byobu tree ripgrep fzf fd-find xsel htop python3-dev \
            python3-pip python3-venv cmatrix

    elif [[ "$OS" == "fedora" || "$OS" == "rhel" || "$OS" == "centos" || "$OS" == "rocky" || "$OS" == "almalinux" ]]; then
        echo "Installing packages for Red Hat based distro..."
        sudo dnf update -y
        sudo dnf install -y vim-enhanced git gh curl wget unzip nodejs npm \
            byobu tree ripgrep fzf fd-find xsel htop cmatrix python3-devel \
            python3-pip python3-virtualenv
        sudo dnf groupinstall -y "Development Tools"
    else
        echo "Unsupported OS: $OS"
        exit 1
    fi
}

sync_configs() {
    echo "Syncing configuration files..."
    
    # Basic dotfiles
    ln -sf ~/dotfiles/.bashrc ~/.bashrc
    ln -sf ~/dotfiles/.vimrc ~/.vimrc
    ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
    ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf ~/dotfiles/.Xmodmap ~/.Xmodmap

    # Byobu
    mkdir -p ~/.byobu
    ln -sf ~/dotfiles/.tmux.conf ~/.byobu/.tmux.conf

    # Neovim
    mkdir -p ~/.config/
    rm -rf ~/.config/nvim
    ln -sf ~/dotfiles/nvim ~/.config/nvim

    # Alacritty
    mkdir -p ~/.config/alacritty
    ln -sf ~/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
}

install_fonts() {
    echo "Installing Hack Nerd Font..."
    FONT_DIR="$HOME/.local/share/fonts"
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
    TEMP_DIR="/tmp/hack-nerd-font"
    
    mkdir -p "$FONT_DIR" "$TEMP_DIR"
    wget -q "$FONT_URL" -O "$TEMP_DIR/Hack.zip"
    unzip -q "$TEMP_DIR/Hack.zip" -d "$TEMP_DIR"
    cp "$TEMP_DIR"/*.ttf "$FONT_DIR/"
    fc-cache -fv
    rm -rf "$TEMP_DIR"
    echo "Font installation completed!"
}

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
