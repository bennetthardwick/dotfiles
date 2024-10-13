local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox dark, medium (base16)'
config.audible_bell = 'Disabled'
config.harfbuzz_features = { 'calt=0' }

return config
