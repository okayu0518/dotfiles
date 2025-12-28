local wezterm = require 'wezterm'

-- Create config object
local config = {}

-- Wayland の IME バグ対策（重要）
config.enable_wayland = false -- 一旦 Xwayland 経由だとかなり安定する
config.audible_bell = "Disabled"
config.window_background_opacity = 0.75

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

--config.font = wezterm.font_with_fallback {
--	  { family = "Noto Sans CJK JP" },
--    --{
--    --    -- 最も汎用的な「等幅」のエイリアス
--		--		family = "Liberation Mono", 
--    --},
--
--    -- Noto Sans JPが確実にあれば、最も推奨されます。
--    { family = "TakaoGothic" },
--    { family = "VL Gothic" },
--}

-- Disable Alt+Enter (fullscreen toggle)
config.keys = {
  {
    key = "Enter",
    mods = "ALT",
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config
