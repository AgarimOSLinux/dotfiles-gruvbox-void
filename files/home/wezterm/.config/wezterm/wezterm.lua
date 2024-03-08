-- {{ REQUIREMENTS }} --
local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- {{ REQUIREMENTS }} --



-- {{ GLOBALS }} --
config.window_close_confirmation = "NeverPrompt"

wezterm.on("gui-startup", function(_)
  local mux = wezterm.mux

  local first_tab, _, window = mux.spawn_window({ args = { "bash" } })
  first_tab:set_title("main")

  local second_tab = window:spawn_tab({ args = { "bash" } })
  second_tab:set_title("auxiliary")

  local third_tab = window:spawn_tab({ args = { "btm" } })
  third_tab:set_title("monitoring")

  first_tab:activate()
end)
-- {{ GLOBALS }} --

-- {{ THEME }} --
config.color_scheme = "GruvboxDark"

config.font = wezterm.font("Iosevka NF")
config.font_size = 14.0

config.enable_tab_bar = false
config.window_padding = {
  left = 30,
  right = 30,
  top = 50,
  bottom = 50,
}
-- {{ THEME }} --

-- {{ ANIMATIONS }} --
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
-- {{ ANIMATIONS }} --

-- {{ BINDINGS }} --
local act = wezterm.action
config.keys = {
  { key = "j", mods = "ALT", action = act.ActivateTabRelative(-1) },
  { key = "k", mods = "ALT", action = act.ActivateTabRelative(1) },
}
-- {{ BINDINGS }} --



-- {{ REQUIREMENTS }} --
return config
-- {{ REQUIREMENTS }} --
