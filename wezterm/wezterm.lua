local wezterm = require("wezterm")
local act = wezterm.action
local font_size = 16.0
local window_background_opacity = 9 * 0.1
local macos_window_background_blur = 7 * 10

return {
  color_scheme = "Teerb",

  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  integrated_title_button_style = "Gnome",
  font_size = font_size,
  font = wezterm.font_with_fallback({
    { family = "Comic Code Ligatures", weight = "Regular" },
    -- "MesloLGS NF",
  }),
  window_padding = {
    left = "1cell",
    right = "1cell",
    top = "0.7cell",
    bottom = "0cell",
  },

  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

  use_ime = true,
  window_background_opacity = window_background_opacity,
  macos_window_background_blur = macos_window_background_blur,
  use_fancy_tab_bar = false,
  enable_tab_bar = false,
  tab_bar_at_bottom = false,
  disable_default_key_bindings = true,

  leader = { key = "s", mods = "CTRL", timeout_milliseconds = 500 },
  colors = {
    brights = {
      "#969896",
      "#cc6666",
      "#b5bd68",
      "#f0c674",
      "#57a2be",
      "#b294bb",
      "#8abeb7",
      "#ffffff",
    },
  },
  keys = {
    -----------------------
    --  BASIC
    -----------------------
    { key = "c", mods = "CMD", action = act.CopyTo("ClipboardAndPrimarySelection") },
    { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
    { key = "/", mods = "CTRL", action = act.QuickSelect },

    -----------------------
    --  PANE
    -----------------------
    { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Right") },
    { key = "h", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Up") },

    -----------------------
    --  TAB
    -----------------------
    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "LeftArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 2 }) },
    { key = "RightArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 2 }) },
    { key = "UpArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 2 }) },
    { key = "DownArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 2 }) },

    -----------------------
    --  MODE
    -----------------------
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },

    -----------------------
    --  QuickSelect
    -----------------------
    { key = "p", mods = "LEADER", action = wezterm.action.QuickSelectArgs({ patterns = { "https?://\\S+" } }) },
  },

  key_tables = {},

  hyperlink_rules = {
    {
      regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
  },

  quick_select_patterns = {
    -- パス（/ や ./, ../ を含みつつ、ASCII のみに制限）
    [[\b(?:/|~/|\.\.?/)?(?:[!-~]+/)*[!-~]+\b]],

    -- URL（ASCII 範囲のみに限定）
    [[[a-zA-Z][a-zA-Z0-9+.-]*://[!-~]+]],

    -- Email（ASCII 文字のみ）
    [[[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}]],

    -- Git commit hash
    [[\b[0-9a-fA-F]{7,40}\b]],

    -- UUID
    [[\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b]],

    -- 汎用トークン（ASCII のみ、3〜90文字）
    [[[A-Za-z0-9_-]{3,90}]],
  }

}
