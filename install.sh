#!/bin/bash

# set -e  # エラーが発生したらスクリプトを停止

# 必要なツールのインストール（LazyVim用）
echo "Updating package lists..."
sudo apt update

# パッケージをインストール
echo "Installing required tools for LazyVim..."
sudo apt install -y git curl wget docker.io docker-compose \
  build-essential unzip python3 python3-pip python3-venv \
  nodejs npm ripgrep fzf xsel fcitx5 fcitx5-mozc

# Google Chromeのインストール
echo "Installing Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install -y # 依存関係を解決
rm google-chrome-stable_current_amd64.deb

# Dockerの設定
echo "Setting up Docker..."
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# Nerd FontsのHackフォントをインストール
echo "Installing Hack Nerd Font..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -P .
unzip -o ./Hack.zip -d ~/.local/share/fonts
fc-cache -fv
rm ./Hack.zip

# Neovim AppImage版のインストール
echo "Installing Neovim AppImage..."
NEOVIM_APPIMAGE_PATH="/usr/local/bin/nvim"
wget -q https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O nvim.appimage
chmod u+x ./nvim.appimage
sudo mv ./nvim.appimage $NEOVIM_APPIMAGE_PATH
chmod u+x $NEOVIM_APPIMAGE_PATH

# .bashrcを同期
echo "Syncing .bashrc from dotfiles..."
ln -sf ~/dotfiles/.bashrc ~/.bashrc

# Neovimの設定を同期
echo "Syncing Neovim configuration from dotfiles..."
ln -sf ~/dotfiles/nvim ~/.config/nvim

# 必要なNode.jsバージョンを確認し、Neovimプラグインをインストール
echo "Checking Node.js and installing Neovim plugin..."
if ! command -v npm &>/dev/null; then
  echo "Node.js is required for GitHub Copilot. Please install it and rerun this script."
  exit 1
fi
sudo npm install -g neovim

# 完了メッセージ
echo "Dotfiles setup is complete! LazyVim, Telescope, GitHub Copilot, Google Chrome, Slack, and Fcitx5 are configured."
echo "Please restart your terminal and re-login to apply Docker group changes."
