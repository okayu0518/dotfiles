#!/bin/bash

# set -e  # エラーが発生したらスクリプトを停止

# 必要なツールのインストール（LazyVim用）
echo "Updating package lists..."
sudo apt update

# パッケージをインストール
# libfuse2はneovim on wslのため
echo "Installing required tools for LazyVim..."
sudo apt install -y git curl wget \
  build-essential unzip python3 python3-pip python3-venv \
  nodejs npm ripgrep fzf fd-find xsel libfuse3 tmux htop

# lagygitのインストール
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz lazygit

# # Google Chromeのインストール
# echo "Installing Google Chrome..."
# wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome-stable_current_amd64.deb
# sudo dpkg -i google-chrome-stable_current_amd64.deb
# sudo apt --fix-broken install -y # 依存関係を解決
# rm google-chrome-stable_current_amd64.deb

# # Dockerの設定
# sudo apt install -y docker.io docker-compose
# echo "Setting up Docker..."
# sudo systemctl enable docker
# sudo systemctl start docker
# sudo usermod -aG docker $USER

# # Nerd FontsのHackフォントをインストール
# echo "Installing Hack Nerd Font..."
# # wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -P .
# wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip -P .
# unzip -o ./Hack.zip -d ~/.local/share/fonts
# fc-cache -fv
# rm ./Hack.zip

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

# .gitconfigを同期
echo "Syncing .gitconfig from dotfiles..."
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# .tmux.confを同期
echo "Syncing .tmux.conf from dotfiles..."
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Neovimの設定を同期
echo "Syncing Neovim configuration from dotfiles..."
# シンボリックリンクが存在しない場合のみ作成
if [ ! -L ~/.config/nvim ]; then
  ln -sf ~/dotfiles/nvim ~/.config/nvim
fi

# 必要なNode.jsバージョンを確認し、Neovimプラグインをインストール
echo "Checking Node.js and installing Neovim plugin..."
if ! command -v npm &>/dev/null; then
  echo "Node.js is required for GitHub Copilot. Please install it and rerun this script."
  exit 1
fi
sudo npm install -g neovim

# 完了メッセージ
echo "Please restart your terminal and re-login to apply Docker group changes."
