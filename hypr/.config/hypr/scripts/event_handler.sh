#!/bin/bash

handle() {
  case $1 in
    monitoradded*)
      # モニターが追加されたらスクリプト実行
      ~/.config/hypr/scripts/monitor_setup.sh
      ;;
    # 必要に応じて monitorremoved も追加可能
    monitorremoved*)
		  hyprctl reload
      ;;
  esac
}

# Hyprlandのソケットを監視してイベントをハンドル
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
