#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

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
                python3-pip python3-venv cmatrix neovim tree-sitter-cli stow
            ;;
        fedora|rhel|centos|rocky|almalinux)
            echo "Installing packages for Red Hat based distro..."
            sudo dnf update -y
            sudo dnf install -y vim-enhanced git gh curl wget unzip nodejs npm \
                tmux tree ripgrep fzf fd-find xsel htop cmatrix python3-devel \
                python3-pip python3-virtualenv neovim tree-sitter-cli stow
            ;;
        arch)
            echo "Installing packages for Arch Linux..."
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm vim git github-cli curl wget base-devel unzip nodejs npm tmux tree ripgrep fzf fd xsel htop cmatrix python python-pip neovim tree-sitter-cli stow hyprland waybar rofi wlogout swaync kanshi ghostty fcitx5-im fcitx5-mozc thunar
            ;;
	*)
	    echo "Unsupported OS: $OS"
            exit 1
            ;;
    esac

#    # fnm (Fast Node Manager) installation
#    if ! command -v fnm &> /dev/null; then
#        echo "Installing fnm..."
#        curl -fsSL https://fnm.vercel.app/install | bash
#    fi
}

# 設定ファイル同期
sync_configs() {
    echo "Syncing configuration files using Stow..."
    
    # ディレクトリ移動
    cd "$SCRIPT_DIR"

    # Stow対象のパッケージリスト
		PACKAGES=(bash zsh git tmux vim emacs nvim wlogout waybar hypr ghostty kanshi rofi swaync fcitx5 Thunar foot wezterm alacritty)

    for package in "${PACKAGES[@]}"; do
        echo "Stowing $package..."
        # -v: verbose, -R: restow (再実行時にリンクを修復), -t: target directory
        stow -v -R -t "$HOME" "$package"
    done

    # Byobu specific setup
    # Byobuは .byobu/.tmux.conf を読み込むため、tmuxの設定へのリンクを作成
    mkdir -p "$HOME/.byobu"
    ln -sf "$SCRIPT_DIR/tmux/.tmux.conf" "$HOME/.byobu/.tmux.conf"

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
    install_packages
    sync_configs
    install_fonts
    setup_network
    echo "Setup completed! Please restart your terminal session."
}

main "$@"
