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
-- config.leader = { key = "phys:Space", mods = "ALT", timeout_milliseconds = 1000 }
local mod_key = "WIN"
config.keys = {
  -- { key = "a", mods = "WIN|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
  { key = "c", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
  { key = "u", mods = mod_key, action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = mod_key, action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = mod_key, action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = mod_key, action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = mod_key, action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = mod_key, action = act.ActivatePaneDirection("Right") },
  { key = "Tab", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "Tab", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "w", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "ALT", action = act.TogglePaneZoomState },
  { key = "o", mods = mod_key, action = act.RotatePanes("Clockwise") },
  { key = "+", mods = mod_key, action = act.IncreaseFontSize },
  { key = "-", mods = mod_key, action = act.DecreaseFontSize },
  { key = "K", mods = "CTRL", action = act.ScrollByLine(-2) },
  { key = "J", mods = "CTRL", action = act.ScrollByLine(2) },
  -- Tab keybindings
  { key = "n", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "u", mods = "ALT", action = act.ActivateTabRelative(-1) },
  { key = "i", mods = "ALT", action = act.ActivateTabRelative(1) },
  { key = "o", mods = "ALT", action = act.MoveTabRelative(-1) },
  { key = "p", mods = "ALT", action = act.MoveTabRelative(1) },
  -- Tab keybindings end
  -- { key = "t", mods = mod_key, action = act.ShowTabNavigator },
  { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
  -- {
  --   key = "phys:Space",
  --   mods = "SHIFT",
  --   action = act.PromptInputLine({
  --     description = wezterm.format({
  --       { Attribute = { Intensity = "Bold" } },
  --       { Foreground = { AnsiColor = "Fuchsia" } },
  --       { Text = "Enter name for new workspace" },
  --     }),
  --     action = wezterm.action_callback(function(window, pane, line)
  --       if line then
  --         window:perform_action(
  --           act.SwitchToWorkspace({
  --             name = line,
  --           }),
  --           pane
  --         )
  --       end
  --     end),
  --   }),
  -- },
  {
    -- key = "phys:Space",
    key = ";",
    mods = "ALT",
    action = act.ShowLauncherArgs({
      flags = "FUZZY|WORKSPACES",
    }),
  },
  { key = "r", mods = "CTRL|SHIFT", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = mod_key,
    action = act.ActivateTab(i - 1),
  })
end

config.key_tables = {
  resize_pane = {
    { key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
  text_zoom_in_out = {
    { key = "-", action = act.DecreaseFontSize },
    { key = "=", action = act.IncreaseFontSize },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
  -- move_tab = {
  --   { key = "h", action = act.MoveTabRelative(-1) },
  --   { key = "j", action = act.MoveTabRelative(-1) },
  --   { key = "Escape", action = "PopKeyTable" },
  --   { key = "Enter", action = "PopKeyTable" },
  -- },
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

  title = wezterm.truncate_right(title, max_width - 4)

  return {
    { Background = { Color = edge_foreground } },
    { Foreground = { Color = edge_background } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = (tab.tab_index + 1) .. ":" .. title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
  }
end)

local function format_duration(seconds)
  local h = math.floor(seconds / 3600)
  local m = math.floor((seconds % 3600) / 60)
  local s = seconds % 60

  -- Use wezterm.format to add colors and attributes if you want
  return string.format("%dh %dm %ds", h, m, s)
end

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
  -- local title = tab:get_title()
  local cmd = pane:get_foreground_process_name()
  cmd = cmd and basename(cmd) or "<!>"
  -- if title and #title > 0 then
  -- 	tab:set_title(title)
  -- else
  -- 	tab:set_title(cmd)
  -- end

  tab:set_title(cmd)

  window:set_right_status(wezterm.format({
    -- { Text = " | " },
    -- { Foreground = { Color = stat_color } },
    -- { Text = " " .. stat },
    -- { Foreground = { Color = "#fff" } },
    -- { Text = " | " },
    -- { Foreground = { Color = "#e0af68" } },
    -- { Text = wezterm.nerdfonts.fa_code .. " " .. cmd },
    -- { Foreground = { Color = "#fff" } },
    -- { Text = " | " },
    -- { Foreground = { Color = "#00ff77" } },
    -- { Text = wezterm.nerdfonts.fa_clock_o .. " " .. format_duration(os.time() - init_time) },
    { Background = { Color = theme.background } },
    { Foreground = { Color = "#e0af68" } },
    { Text = SOLID_RIGHT_ARROW },
    { Background = { Color = "#e0af68" } },
    { Foreground = { Color = theme.background } },
    { Text = " " .. wezterm.nerdfonts.fa_code .. " " .. cmd .. " " },
    { Foreground = { Color = theme.background } },
    { Background = { Color = "#e0af68" } },
    -- { Text = SOLID_RIGHT_ARROW },
    -- Timer section
    -- { Background = { Color = theme.background } },
    -- { Foreground = { Color = "#00ff77" } },
    -- { Text = SOLID_RIGHT_ARROW },
    -- { Background = { Color = "#00ff77" } },
    -- { Foreground = { Color = theme.background } },
    -- { Text = " " .. wezterm.nerdfonts.fa_clock_o .. " " .. format_duration(os.time() - init_time) .. " " },
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
