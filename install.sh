#!/bin/bash

# 必要なツールのインストール（例えば、git, vim, zshなど）
sudo apt update
sudo apt install -y git curl wget \
  build-essential unzip vim python3 python3-pip \
  python3-venv nodejs npm ripgrep fzf xsel

# シンボリックリンクの作成
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

mkdir -p ~/.vim/undo

# 完了メッセージ
echo "Dotfiles setup is complete! Please restart your terminal."

