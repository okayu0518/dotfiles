#!/bin/bash

# set -e  # エラーが発生したらスクリプトを停止

# 必要なツールのインストール（LazyVim用）
echo "Updating package lists..."
sudo apt update

# 普段遣いパッケージたちをインストール
echo "Installing required tools for LazyVim..."
sudo apt install -y vim-gtk3 git gh curl wget \
  build-essential unzip nodejs npm zsh byobu

#たまにつかう便利ツール
sudo apt install -y tree ripgrep fzf fd-find xsel htop

# pythonたち
sudo apt install -y python3-dev python3-pip python3-venv

# for neovim on wsl
# sudo apt install -y libfuse2

# ネタ
sudo apt install -y cmatrix

# # for yazi
# sudo apt install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
# 
# #install yazi
# echo "Installing yazi..."
# wget -qO yazi.zip https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
# unzip yazi-.zip -d yazi-temp
# sudo mv yazi-temp/*/yazi /usr/local/bin
# rm -rf yazi.zip yazi-temp

# .bashrcを同期
echo "Syncing .bashrc from dotfiles..."
ln -sf ~/dotfiles/.bashrc ~/.bashrc

# .zshrcを同期
echo "Syncing .zshrc from dotfiles..."
ln -sf ~/dotfiles/.zshrc ~/.zshrc
chsh -s $(which zsh)

# .vimrcを同期
echo "Syncing .vimrc from dotfiles..."
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# .gitconfigを同期
echo "Syncing .gitconfig from dotfiles..."
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# .tmux.confを同期
echo "Syncing .tmux.conf from dotfiles..."
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# .byobuを同期
echo "Syncing .byobu from dotfiles..."
mkdir -p ~/.byobu
ln -sf ~/dotfiles/.tmux.conf ~/.byobu/.tmux.conf

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

# # Neovim AppImage版のインストール
# echo "Installing Neovim AppImage..."
# NEOVIM_APPIMAGE_PATH="/usr/local/bin/nvim"
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
# chmod u+x nvim-linux-x86_64.appimage
# sudo mv ./nvim-linux-x86_64.appimage $NEOVIM_APPIMAGE_PATH
#
# # 必要なNode.jsバージョンを確認し、Neovimプラグインをインストール
# echo "Checking Node.js and installing Neovim plugin..."
# if ! command -v npm &>/dev/null; then
#   echo "Node.js is required for GitHub Copilot. Please install it and rerun this script."
#   exit 1
# fi
# sudo npm install -g neovim

# kut wifiの優先度設定(勝手につながってうざいから)
sudo nmcli connection modify "kut" connection.autoconnect-priority -1

# 完了メッセージ
echo "Please restart your terminal and re-login to apply Docker group changes."
