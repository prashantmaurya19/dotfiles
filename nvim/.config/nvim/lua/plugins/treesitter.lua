return {
  -- { "nvim-treesitter/playground" },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "lua", "javascript", "python", "rust", "java" })
    end,
  },
}
