return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  dependencies = {
    -- include a picker of your choice, see picker section for more details
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lang = "java",
    hooks = {
      ---@type fun()[]
      ["enter"] = {
        function()
          -- vim.cmd("silent! %foldopen!")
          vim.cmd("Copilot disable")
        end,
      },
    },
    -- configuration goes here
  },
}
