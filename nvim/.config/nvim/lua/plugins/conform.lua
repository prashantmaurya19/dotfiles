return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      local conform = require("conform")
      conform.setup({
        timeout_ms = 4000,
        async = false,
        -- format_on_save = {
        --   enabled = false,
        -- },
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          rust = { "rustfmt" },
          html = { "prettier" },
          css = { "prettier" },
          yaml = { "prettier" },
          scss = { "prettier" },
          jsonc = { "prettier" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          json = { "prettier" },
          markdown = { "prettier" },
          xml = { "xmlformatter" },
          java = { "google-java-format" },
          sh = { "shfmt" },
          sql = { "sqlfmt" },
        },
        formatters = {
          stylua = {
            append_args = {
              "--indent-width",
              vim.PM.g.shiftwidth.lua,
              "--indent-type",
              "Spaces",
            },
          },
          prettier = {
            "--tab-width ",
            vim.PM.g.shiftwidth.javascriptreact,
            "--use-tabs false",
          },
          shfmt = {
            append_args = {
              "--indent",
              vim.PM.g.shiftwidth.sh,
            },
          },
        },
      })
    end,
  },
}
