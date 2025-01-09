#!/bin/bash

# 必要なツールのインストール（DockerやNeovim関連）
sudo apt update
sudo apt install -y git curl wget neovim docker.io docker-compose \
  build-essential unzip python3 python3-pip python3-venv \
  nodejs npm ripgrep fzf xsel

# Dockerの設定
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# Neovim用ディレクトリを作成してシンボリックリンクを作成
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/init.lua ~/.config/nvim/init.lua

# Neovim用のプラグインディレクトリを作成
mkdir -p ~/.local/share/nvim/site/pack
mkdir -p ~/.config/nvim/lua

# 完了メッセージ
echo "Dotfiles setup is complete! Please restart your terminal and re-login to apply Docker group changes."
