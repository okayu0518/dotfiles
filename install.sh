#!/bin/bash

# set -e  # エラーが発生したらスクリプトを停止

# OS判定
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unsupported OS"
    exit 1
fi

# change capslock to ctrl
echo "setxkbmap -option ctrl:nocaps" >> ~/.xprofile
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

# パッケージマネージャごとに分岐
if [[ "$OS" == "ubuntu" || "$OS" == "debian" || "$OS" == "linuxmint" ]]; then
    echo "Detected Debian/Ubuntu. Installing packages with apt..."
    sudo apt update
    sudo apt install -y vim-gtk3 git gh curl wget \
        build-essential unzip nodejs npm byobu \
        tree ripgrep fzf fd-find xsel htop \
        python3-dev python3-pip python3-venv cmatrix

elif [[ "$OS" == "fedora" || "$OS" == "rhel" || "$OS" == "centos" || "$OS" == "rocky" || "$OS" == "almalinux" ]]; then
    echo "Detected Red Hat based distro. Installing packages with dnf..."
    sudo dnf update -y
    sudo dnf install -y vim-enhanced git gh curl wget \
        unzip nodejs npm byobu \
        tree ripgrep fzf fd-find xsel htop cmatrix \
        python3-devel python3-pip python3-virtualenv

    # build-essential 相当
    sudo dnf groupinstall -y "Development Tools"

else
    echo "Unsupported OS: $OS"
    exit 1
fi

# .bashrcを同期
echo "Syncing .bashrc from dotfiles..."
ln -sf ~/dotfiles/.bashrc ~/.bashrc

# .vimrcを同期
echo "Syncing .vimrc from dotfiles..."
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# .gitconfigを同期
echo "Syncing .gitconfig from dotfiles..."
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# .tmux.confを同期
echo "Syncing .tmux.conf from dotfiles..."
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# .Xmodmapを同期
echo "Syncing .Xmodmap from dotfiles..."
ln -sf ~/dotfiles/.Xmodmap ~/.Xmodmap

# .byobuを同期
echo "Syncing .byobu from dotfiles..."
mkdir -p ~/.byobu
ln -sf ~/dotfiles/.tmux.conf ~/.byobu/.tmux.conf

# Neovimの設定を同期
echo "Syncing Neovim configuration from dotfiles..."
mkdir -p ~/.config/
rm -rf ~/.config/nvim
if [ ! -L ~/.config/nvim ]; then
    ln -sf ~/dotfiles/nvim ~/.config/nvim
fi

# alacrittyの設定を同期
echo "Syncing Alacritty configuration from dotfiles..."
mkdir -p ~/.config/alacritty
if [ ! -L ~/.config/alacritty/alacritty.toml ]; then
    ln -sf ~/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
fi

# Hack Nerd Fontのインストール
echo "Installing Hack Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
TEMP_DIR="/tmp/hack-nerd-font"
mkdir -p "$FONT_DIR" "$TEMP_DIR"
echo "Downloading Hack Nerd Font..."
wget -q "$FONT_URL" -O "$TEMP_DIR/Hack.zip"
echo "Extracting and installing Hack Nerd Font..."
unzip -q "$TEMP_DIR/Hack.zip" -d "$TEMP_DIR"
cp "$TEMP_DIR"/*.ttf "$FONT_DIR/"
echo "Updating font cache..."
fc-cache -fv
rm -rf "$TEMP_DIR"
echo "Hack Nerd Font has been installed successfully!"

# kut wifiの優先度設定
sudo nmcli connection modify "kut" connection.autoconnect-priority -1

# 完了メッセージ
echo "Setup completed. Please restart your terminal session."
