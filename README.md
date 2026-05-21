# Dotfiles - Keep It Simple

シンプルで効率的な開発環境設定

## インストール

```bash
git clone https://github.com/okayu0518/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## CUI 環境向けの手動コマンド

`install.sh` では入れないものは、必要なときだけ手動で実行する。

### Arch

```bash
sudo pacman -S --noconfirm hyprland waybar rofi swaync kanshi ghostty fcitx5-im fcitx5-mozc thunar
```

### Debian / Ubuntu

```bash
sudo apt install -y hyprland waybar rofi swaync kanshi ghostty thunar fcitx5 fcitx5-mozc
```

### Fedora

```bash
sudo dnf install -y hyprland waybar rofi swaync kanshi ghostty thunar fcitx5 fcitx5-mozc
```

## 含まれる設定

- **Neovim**: ミニマルで高速な設定
- **Emacs**: init.el設定（Emacs 29+推奨）
- **Terminal**: Alacritty, Wezterm, Bash, Zsh, Tmux
- **Git**: 基本設定
- **Font**: Hack Nerd Font
- **Node.js**: fnm (Fast Node Manager)

## キーバインド

### Neovim
- `<leader>ff`: ファイル検索
- `<leader>fg`: 文字列検索
- `<leader>fb`: バッファ一覧
- `Alt+j/k`: 行移動
- `Ctrl+hjkl`: ウィンドウ移動

### システム
- `CapsLock`: Ctrl に変更
