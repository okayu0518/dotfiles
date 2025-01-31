#!/bin/bash

# set -e  # エラーが発生したらスクリプトを停止

# 必要なツールのインストール（LazyVim用）
echo "Updating package lists..."
sudo apt update

# パッケージをインストール
# libfuse2はneovim on wslのため
echo "Installing required tools for LazyVim..."
sudo apt install -y vim git curl wget \
  build-essential unzip python3 python3-pip python3-venv \
  nodejs npm ripgrep fzf fd-find xsel libfuse2 tmux htop

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

# Neovimの設定を同期
echo "Syncing Neovim configuration from dotfiles..."
mkdir -p ~/.config/nvim
# シンボリックリンクが存在しない場合のみ作成
if [ ! -L ~/.config/nvim ]; then
  ln -sf ~/dotfiles/nvim ~/.config/nvim
fi

# alacrittyの設定を同期
echo "Syncing Alacritty configuration from dotfiles..."
mkdir -p ~/.config/alacritty
# シンボリックリンクが存在しない場合のみ作成
if [ ! -L ~/.config/alacritty/alacritty.yml ]; then
  ln -sf ~/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
fi

# # Dockerの設定
# sudo apt install -y docker.io docker-compose
# echo "Setting up Docker..."
# sudo systemctl enable docker
# sudo systemctl start docker
# sudo usermod -aG docker $USER

# Neovim AppImage版のインストール
echo "Installing Neovim AppImage..."
NEOVIM_APPIMAGE_PATH="/usr/local/bin/nvim"
wget -q https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O nvim.appimage
chmod u+x ./nvim.appimage
sudo mv ./nvim.appimage $NEOVIM_APPIMAGE_PATH
chmod u+x $NEOVIM_APPIMAGE_PATH

# 必要なNode.jsバージョンを確認し、Neovimプラグインをインストール
echo "Checking Node.js and installing Neovim plugin..."
if ! command -v npm &>/dev/null; then
  echo "Node.js is required for GitHub Copilot. Please install it and rerun this script."
  exit 1
fi
sudo npm install -g neovim

# 完了メッセージ
echo "Please restart your terminal and re-login to apply Docker group changes."
