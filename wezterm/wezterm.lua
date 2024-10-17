local wezterm = require 'wezterm'
local act = wezterm.action

local dimmer = { brightness = 0.1 }

return {
  color_scheme = "Teerb",

  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  integrated_title_button_style = "Gnome",
  font_size = 18.0,
  font = wezterm.font("MesloLGS NF"),
  window_padding = {
    left = '1cell',
    right = '1cell',
    top = '0.7cell',
    bottom = '0cell',
  },

  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  use_ime = true,
  window_background_opacity = 0.9,
  macos_window_background_blur = 100,
  -- background = {
  --   {
  --     source = {
  --       File = "/Users/yuma/Pictures/Wallpapers/pexels-shanekell.jpg",
  --     },
  --     repeat_x = 'Mirror',
  --     hsb = dimmer,
  --     attachment = { Parallax = 0.1 },
  --   },
  -- },
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  tab_bar_at_bottom = false,
  disable_default_key_bindings = true,

  leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 500, },
  keys = {
    -----------------------
    --  BASIC
    -----------------------
    { key = 'c', mods = 'CMD', action = act.CopyTo 'ClipboardAndPrimarySelection' },
    { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
    { key = '/', mods = 'CTRL', action = act.QuickSelect },

    -----------------------
    --  PANE
    -----------------------
    { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 's', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'LEADER|CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = 'h', mods = 'LEADER|CTRL', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'LEADER|CTRL', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'LEADER|CTRL', action = act.ActivatePaneDirection 'Up' },

    -----------------------
    --  TAB
    -----------------------
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    { key = 'LeftArrow', mods = 'SHIFT', action = act.AdjustPaneSize {"Left", 2} },
    { key = 'RightArrow', mods = 'SHIFT', action = act.AdjustPaneSize {"Right", 2} },
    { key = 'UpArrow', mods = 'SHIFT', action = act.AdjustPaneSize {"Up", 2} },
    { key = 'DownArrow', mods = 'SHIFT', action = act.AdjustPaneSize {"Down", 2} },

    -----------------------
    --  MODE
    -----------------------
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
  },

  key_tables = {},

  hyperlink_rules = {
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },
  },

  quick_select_patterns = {
    '[0-9a-zA-Z_-]{6,40}',
  },
}
