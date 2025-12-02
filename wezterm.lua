local wezterm = require 'wezterm'

-- Create config object
local config = {}

-- Wayland の IME バグ対策（重要）
config.enable_wayland = false -- 一旦 Xwayland 経由だとかなり安定する
config.audible_bell = "Disabled"
config.window_background_opacity = 0.8

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
font = wezterm.font_with_fallback {
	"JetBrains Mono",
	"Noto Sans CJK JP",
	"Noto Sans JP",
}

return config
