return {
  "rmagatti/auto-session",
  lazy = false,

  opts = {
    auto_restore = false,
    bypass_save_filetypes = { "netrw" },
    session_lens = {
      picker = "telescope",
      mappings = {
        -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
        delete_session = { "i", "<C-d>" },
        alternate_session = { "i", "<C-s>" },
        copy_session = { "i", "<C-y>" },
      },
      picker_opts = {
        -- border = true,
        -- layout_config = {
        --   width = 0.8, -- Can set width and height as percent of window
        --   height = 0.5,
        -- },

        -- For Snacks, you can set layout options here, see:
        -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
        --
        -- preset = "dropdown",
        -- preview = false,
        -- layout = {
        --   width = 0.4,
        --   height = 0.4,
        -- },

        -- For Fzf-Lua, picker_opts just turns into winopts, see:
        -- https://github.com/ibhagwan/fzf-lua#customization
        --
        --  height = 0.8,
        --  width = 0.50,
      },

      -- Telescope only: If load_on_setup is false, make sure you use `:AutoSession search` to open the picker as it will initialize everything first
      load_on_setup = true,
    },
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    -- log_level = 'debug',
  },
}
