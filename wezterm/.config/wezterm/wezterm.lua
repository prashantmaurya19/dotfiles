local wezterm = require("wezterm")
local act = wezterm.action
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local config = wezterm.config_builder()
-- local init_time = os.time()
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.window_padding = {
  left = 2,
  right = 0,
  top = 0,
  bottom = 0,
}
config.font_size = 15
config.color_scheme = "Campbell (Gogh)"
config.font = wezterm.font("FiraCode Nerd Font")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.95
config.window_background_image_hsb = {
  brightness = 0.03,
  hue = 1,
  saturation = 1.0,
}
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.2,
}
local theme = {
  background = "#0b0022",
  active_tab = {
    bg_color = "#ff2042",
    fg_color = "#c0c0c0",
    intensity = "Normal",
    underline = "None",
    italic = false,
    strikethrough = false,
  },
  inactive_tab = {
    bg_color = "#1b1032",
    fg_color = "#808080",
  },
  inactive_tab_hover = {
    bg_color = "#3b3052",
    fg_color = "#909090",
    italic = true,
  },
  new_tab = {
    bg_color = "#1b1032",
    fg_color = "#808080",
  },
  new_tab_hover = {
    bg_color = "#3b3052",
    fg_color = "#909090",
    italic = true,
  },
}
--colors
config.colors = {
  tab_bar = theme,
}

--keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
-- local mod_key = "WIN"
config.keys = {
  { key = "a", mods = "CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
  { key = "c", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
  { key = "u", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "Tab", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "Tab", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "j", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "l", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "w", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  -- { key = "o", mods = mod_key, action = act.RotatePanes("Clockwise") },
  -- Tab keybindings
  { key = "n", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "u", mods = "ALT", action = act.ActivateTabRelative(-1) },
  { key = "i", mods = "ALT", action = act.ActivateTabRelative(1) },
  { key = "o", mods = "ALT", action = act.MoveTabRelative(-1) },
  { key = "p", mods = "ALT", action = act.MoveTabRelative(1) },
  -- Tab keybindings end
  -- { key = "t", mods = mod_key, action = act.ShowTabNavigator },
  { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
  {
    key = "e",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        -- 'line' is nil if the user hit Escape
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  {
    key = "phys:Space",
    mods = "LEADER",
    action = act.ShowLauncherArgs({
      flags = "FUZZY|WORKSPACES",
    }),
  },
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  { key = "-", mods = "LEADER", action = act.ActivateKeyTable({ name = "text_zoom_in_out", one_shot = false }) },
  { key = "s", mods = "LEADER", action = act.ActivateKeyTable({ name = "term_scroll", one_shot = false }) },
  { key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "nav_pane", one_shot = false }) },
}

-- for i = 1, 9 do
--   table.insert(config.keys, {
--     key = tostring(i),
--     mods = mod_key,
--     action = act.ActivateTab(i - 1),
--   })
-- end

config.key_tables = {
  term_scroll = {
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
    { key = "j", action = act.ScrollByLine(2) },
    { key = "k", action = act.ScrollByLine(-2) },
    { key = "g", action = act.ScrollToTop },
    { key = "G", action = act.ScrollToBottom },
  },
  resize_pane = {
    { key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
  nav_pane = {
    { key = "h", action = act.ActivatePaneDirection("Left") },
    { key = "j", action = act.ActivatePaneDirection("Down") },
    { key = "k", action = act.ActivatePaneDirection("Up") },
    { key = "l", action = act.ActivatePaneDirection("Right") },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
  text_zoom_in_out = {
    { key = "-", action = act.DecreaseFontSize },
    { key = "=", action = act.IncreaseFontSize },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
}
config.use_fancy_tab_bar = false
config.status_update_interval = 5000
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, configs, hover, max_width)
  local edge_background = "#0b0022"
  local background = "#1b1032"
  local foreground = "#808080"

  if tab.is_active then
    background = "#2b2042"
    foreground = "#c0c0c0"
  elseif hover then
    background = "#3b3052"
    foreground = "#909090"
  end
  local edge_foreground = background
  local title = tab.tab_title

  -- title = wezterm.truncate_right(title, max_width - 4)

  return {
    { Background = { Color = edge_foreground } },
    { Foreground = { Color = edge_background } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = (tab.active_pane.is_zoomed and "[z]" or "") .. (tab.tab_index + 1) .. ":" .. title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
  }
end)

wezterm.on("update-status", function(window, pane)
  -- Workspace name
  local stat = "" .. window:active_workspace()
  local stat_color = "#f7768e"
  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = "#7dcfff"
  end
  if window:leader_is_active() then
    stat = "LDR"
    stat_color = "#bb9af7"
  end

  local stat_symbol = wezterm.nerdfonts.fa_linux
  if stat == "default" then
    stat_symbol = wezterm.nerdfonts.cod_terminal_linux
  elseif stat == "resize_pane" then
    stat_symbol = wezterm.nerdfonts.md_resize
  end

  local tab = pane:window():active_tab()
  local title = tab:get_title()
  local cmd = pane:get_foreground_process_name()
  cmd = cmd and basename(cmd) or "<!>"
  if not (title and #title > 0) then
    title = cmd
  end
  tab:set_title(title)

  window:set_right_status(wezterm.format({
    -- zoomed,
    { Background = { Color = theme.background } },
    { Foreground = { Color = "#e0af68" } },
    { Text = SOLID_RIGHT_ARROW },
    { Background = { Color = "#e0af68" } },
    { Foreground = { Color = theme.background } },
    { Text = " " .. wezterm.nerdfonts.fa_code .. " " .. cmd .. " " },
    { Foreground = { Color = theme.background } },
    { Background = { Color = "#e0af68" } },
  }))

  window:set_left_status(wezterm.format({
    { Background = { Color = stat_color } },
    { Foreground = { Color = theme.background } },
    { Text = " " },
    { Attribute = { Intensity = "Bold" } },
    { Text = stat_symbol .. " " .. stat },
    { Foreground = { Color = stat_color } },
    { Background = { Color = theme.background } },
    { Text = SOLID_LEFT_ARROW },
  }))
  return {
    font_size = 30,
  }
end)
return config
