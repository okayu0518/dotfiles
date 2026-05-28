local wezterm = require 'wezterm'

-- Create config object
local config = {}

-- Wayland の IME バグ対策（重要）
config.enable_wayland = true
config.audible_bell = "Disabled"
config.window_background_opacity = 0.8

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Noto Sans CJK JP",
})
config.font_size = 12.0
config.window_close_confirmation = "NeverPrompt"

-- Disable Alt+Enter (fullscreen toggle)
config.keys = {
  {
    key = "Enter",
    mods = "ALT",
    action = wezterm.action.DisableDefaultAssignment,
  },
}

--config.front_end = "OpenGL"

return config
