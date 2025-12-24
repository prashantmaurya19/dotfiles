return {
  "L3MON4D3/LuaSnip",
  -- build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local sn = ls.snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    -- local r = ls.restore_node
    local extra = require("luasnip.extras")
    local rep = extra.rep
    local fmt = require("luasnip.extras.fmt").fmt
    -- local l = extra.lambda
    -- local p = require("luasnip.extras").partial
    -- local m = require("luasnip.extras").match
    -- local n = require("luasnip.extras").nonempty
    -- local dl = require("luasnip.extras").dynamic_lambda
    -- local fmta = require("luasnip.extras.fmt").fmta
    -- local types = require("luasnip.util.types")
    -- local conds = require("luasnip.extras.conditions")
    -- local conds_expand = require("luasnip.extras.conditions.expand")
    --keybinding
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    local snippets = {
      html = {
        s("tag", fmt("<{}{}>{}</{}>", { i(1), i(2), i(0), rep(1) })),
        s("ctag", fmt("<{}/>", i(0))),
        s(
          "!!!",
          fmt(
            [[
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{}</title>
  </head>
  <body>
  {}
  </body>
</html>
				]],
            { i(1), i(0) }
          )
        ),
      },
      javascript = {
        s(
          "jsdoc",
          fmt(
            [[
/**  
 * {}
*/
				]],
            { i(0) }
          )
        ),
        s("tag", fmt("<{}{}>{}</{}>", { i(1), i(2), i(0), rep(1) })),
        s("ctag", fmt("<{}/>", i(0))),
      },

      javascriptreact = {
        s(
          "jsdoc",
          fmt(
            [[
/**  
 * {}
*/
				]],
            { i(0) }
          )
        ),
        s("tag", fmt("<{}{}>{}</{}>", { i(1), i(2), i(0), rep(1) })),
        s("ctag", fmt("<{}/>", i(0))),
      },
      python = {
        s(
          "doc",
          fmt(
            [[
"""
{}
"""
				]],
            { i(0) }
          )
        ),
      },
      java = {
        s(
          "jsdoc",
          fmt(
            [[
/**  
 * {}
*/
				]],
            { i(0) }
          )
        ),
      },
    }

    for key, value in pairs(snippets) do
      ls.add_snippets(key, value)
    end
  end,
}
