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
config.enable_tab_bar = false

config.font = wezterm.font("Iosevka NF")
config.font_size = 14.0
config.cell_width = 0.9

config.window_background_opacity = 0.85
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

  { key = "v", mods = "ALT", action = act.SplitVertical { domain = 'CurrentPaneDomain', args = { 'bash' } } },
  { key = "s", mods = "ALT", action = act.SplitHorizontal { domain = 'CurrentPaneDomain', args = { 'bash' } } },
  { key = "q", mods = "ALT", action = act.CloseCurrentPane { confirm = false } },
  { key = "j", mods = "ALT|CTRL", action = act.ActivatePaneDirection 'Down' },
  { key = "k", mods = "ALT|CTRL", action = act.ActivatePaneDirection 'Up' },
  { key = "h", mods = "ALT|CTRL", action = act.ActivatePaneDirection 'Left' },
  { key = "l", mods = "ALT|CTRL", action = act.ActivatePaneDirection 'Right' },
}
config.pane_focus_follows_mouse = true
-- {{ BINDINGS }} --



-- {{ REQUIREMENTS }} --
return config
-- {{ REQUIREMENTS }} --
