#!/bin/bash

# 内蔵ディスプレイの識別名 (hyprctl monitors で確認)
INTERNAL_MONITOR="eDP-1"
# ターゲットとなる外部モニターの識別名（モデル名の一部など）
TARGET_MONITOR_MODEL="LG Electronics LG ULTRAGEAR 210NTLE4R208"

# 現在接続されている全てのモニター情報を取得
MONITORS=$(hyprctl monitors all)

if echo "$MONITORS" | grep -q "$TARGET_MONITOR_MODEL"; then
    # 特定のモニターがある場合：内蔵を無効化、外部を優先
    hyprctl keyword monitor "$INTERNAL_MONITOR, disable"
		hyprctl keyword monitor "DP-1, 2560x1440, auto, 1"
    #hyprctl keyword monitor ", preferred, auto, 1"
fi
