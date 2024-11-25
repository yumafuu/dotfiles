local wezterm = require("wezterm")
local act = wezterm.action

return {
  color_scheme = "Teerb",

  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  integrated_title_button_style = "Gnome",
  font_size = 18.0,
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
  window_background_opacity = 0.9,
  macos_window_background_blur = 100,
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  tab_bar_at_bottom = false,
  disable_default_key_bindings = true,

  leader = { key = "s", mods = "CTRL", timeout_milliseconds = 500 },
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
  },

  key_tables = {},

  hyperlink_rules = {
    {
      regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
  },

  quick_select_patterns = {
    "[0-9a-zA-Z_-]{3,90}",                        -- Words
    "https?://[\\w.-]+\\.[a-z]{2,}[\\w/?.=&%-]*", -- URLs
    "/[\\w.-/]+",                                 -- File paths
    "[\\w._%+-]+@[\\w.-]+\\.[a-z]{2,}",           -- Emails
    "\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b",           -- IP addresses
    "\\b0x[0-9a-fA-F]+\\b",                       -- Hex numbers
    "\\b[0-9a-fA-F]{7,40}\\b",                    -- Git hashes
    "\\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\\b" -- UUIDs
  },
}
