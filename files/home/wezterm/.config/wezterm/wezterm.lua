-- {{ REQUIREMENTS }} --
local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- {{ REQUIREMENTS }} --



-- {{ THEME }} --
config.color_scheme = "GruvboxDark"
config.font = wezterm.font("Iosevka NF")
config.font_size = 14.0
-- {{ THEME }} --

-- {{ ANIMATION }} --
config.animation_fps = 120
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
-- {{ ANIMATION }} --



-- {{ REQUIREMENTS }} --
return config
-- {{ REQUIREMENTS }} --
