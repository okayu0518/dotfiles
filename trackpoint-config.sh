#!/bin/bash
# TrackPointの加速度を設定
sleep 5  # X起動完了待ち（重要）

# デバイス名が変わる可能性があるので、IDで取得
DEVICE_NAME="TPPS/2 IBM TrackPoint"
ACCEL_PROP="libinput Accel Speed"

DEVICE_ID=$(xinput list --id-only "$DEVICE_NAME")

if [ -n "$DEVICE_ID" ]; then
    xinput set-prop "$DEVICE_ID" "$ACCEL_PROP" 0.05
fi
