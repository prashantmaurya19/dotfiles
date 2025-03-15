local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

config.font_size = 12.4
-- For example, changing the color scheme:
config.color_scheme = "Campbell (Gogh)"
-- config.color_scheme = "Catch Me If You Can (terminal.sexy)"
config.font = wezterm.font("FiraMono Nerd Font Mono")
config.default_prog = { "pwsh.exe" }
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- config.window_background_image_stretch = "Cover"
config.window_background_opacity = 1.0
config.window_background_image =
  "C:\\Users\\prash\\Documents\\wellpapers\\demon-slayer-zenitsu-agatsuma-god-speed-desktop-wallpaper.jpg"

config.window_background_image_hsb = {
  brightness = 0.03,
  hue = 1.0,
  saturation = 1.0,
}
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.2,
}

--colors
config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = "#0b0022",

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = "#2b2042",
      -- The color of the text for the tab
      fg_color = "#c0c0c0",

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = "Normal",

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = "None",

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = "#1b1032",
      fg_color = "#808080",

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = "#3b3052",
      fg_color = "#909090",
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = "#1b1032",
      fg_color = "#808080",

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = "#3b3052",
      fg_color = "#909090",
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}
--keys
config.leader = { key = "phys:Space", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- { key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
  { key = "c", mods = "LEADER", action = act.ActivateCopyMode },
  { key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },
  { key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  { key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
  -- Tab keybindings
  { key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "n", mods = "LEADER", action = act.ShowTabNavigator },
  {
    key = "e",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Renaming Tab Title...:" },
      }),
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
}
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

config.key_tables = {
  resize_pane = {
    { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
  move_tab = {
    { key = "h", action = act.MoveTabRelative(-1) },
    { key = "j", action = act.MoveTabRelative(-1) },
    { key = "k", action = act.MoveTabRelative(1) },
    { key = "l", action = act.MoveTabRelative(1) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
}
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = true
-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   local title = tab.tab_title

--   if not title or title == "" then
--     -- local pane = tab.active_pane
--     title = tab.active_pane:get_foreground_process_name()
--     -- if pane then
--     --   local cmd = pane:get_foreground_process_name()
--     --   if cmd then
--     --     title = string.gsub(cmd, "(.*[/\\])(.*)", "%2")
--     --   else
--     --     title = "Shell" -- Default tab title if no command is running
--     --   end
--     -- else
--     --   title = "New Tab" -- Default tab title if pane is not available
--     -- end
--   end
--   local title_len = 5
--   if #title > title_len then
--     title = string.sub(title, 1, title_len) .. "~"
--   end
--   -- title = "New Tab" -- Default tab title if pane is not available
--   return {
--     { Text = " " .. (tab.tab_index + 1) .. "-" .. title .. " " .. #title },
--     -- { Text = "title " },
--   }
-- end)
wezterm.on("update-status", function(window, pane)
  local cmd = pane:get_foreground_process_name()
  cmd = cmd and string.gsub(cmd, "(.*[/\\])(.*)", "%2") or ""

  -- Time
  local time = wezterm.strftime("%H:%M")
  -- local battery = wezterm.battery_info()[1]
  -- local battery_percentage = battery and battery.state_of_charge or nil
  -- local battery_color = "#ffffff" -- Default color (white)
  -- if battery_percentage > 0.7 then
  --   battery_color = "#a0e878" -- Green for high percentage
  -- elseif battery_percentage > 0.3 then
  --   battery_color = "#ffdd57" -- Yellow for medium percentage
  -- else
  --   battery_color = "#f28b82" -- Red for low percentage
  -- end
  -- Current command

  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    -- { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
    { Text = " | " },
    { Foreground = { Color = "#e0af68" } },
    { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
    "ResetAttributes",
    -- { Text = " | " },
    -- -- { Foreground = { Color = battery_color } },
    -- {
    --   Text = wezterm.nerdfonts.fa_battery .. " " .. bat,
    --   -- .. (battery_percentage and string.format("%.0f%%", battery_percentage * 100) .. "%" or "N/A"),
    -- },
    -- "ResetAttributes",
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
    { Text = "  " },
  }))
end)

wezterm.on("update-status", function(window, pane)
  -- Workspace name
  local stat = window:active_workspace()
  local stat_color = "#f7768e"
  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = "#7dcfff"
  end
  if window:leader_is_active() then
    stat = "LDR"
    stat_color = "#bb9af7"
  end

  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Foreground = { Color = stat_color } },
    { Text = " " },
    { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
    { Text = " |" },
  }))
  return {
    font_size = 30,
  }
end)
return config
