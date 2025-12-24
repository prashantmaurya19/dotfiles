local builtin = require("telescope.builtin")
local pm_telescope_ext = require("pm_user.telescope_ext")
local keyset = vim.keymap.set
local M = {
  on_lsp_attach = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    keyset("n", "<S-k>", vim.lsp.buf.hover, opts)
    keyset("n", "<leader>a", vim.lsp.buf.code_action, opts)
    keyset("n", "<S-l>", function()
      vim.diagnostic.open_float(nil, { focus = false })
    end, opts)
    keyset("n", "]d", function()
      -- vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
      vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
    end, opts)
    keyset("n", "[d", function()
      -- vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
      vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
    end, opts)
    keyset("n", ";", vim.lsp.buf.signature_help, opts)
    keyset("n", "gd", function()
      vim.lsp.buf.references()
    end, opts)
    keyset("n", "gD", vim.lsp.buf.declaration, opts)
    keyset("n", "gd", vim.lsp.buf.definition, opts)
    keyset("n", "<F2>", vim.lsp.buf.rename, opts)
  end,

  telescope_opt = function(opt)
    return table.update({
      previewer = false,
      layout_strategies = "vertical",
      line_width = 0.25,
      path_display = function(_, path)
        local dirs = vim.PM.file.parse(path)
        dirs.directories = table.slice(dirs.directories, #dirs.directories - 3, #dirs.directories)
        table.insert(dirs.directories, dirs.filename)
        return vim.PM.text.join(vim.PM.g.path_sep, dirs.directories)
      end,
    }, opt or {})
  end,

  keyargs = function(...)
    local keyarg = {}
    for k, value in ipairs(...) do
      if k ~= "desc" then
        keyarg[value] = true
      else
        keyarg[k] = value
      end
    end
    return keyarg
  end,
  mapKeyForNewtab = function(mode, map, func, kmode)
    if not vim.startswith(map, "<leader>") then
      return
    end

    vim.keymap.set(mode, map, func, kmode)
    vim.keymap.set(mode, "<leader>n" .. string.sub(map, 9, #map), function()
      local pre_buf = {
        bufnr = vim.api.nvim_get_current_buf(),
      }
      vim.cmd("tabnew")
      func(pre_buf)
    end, kmode)
  end,
}
keyset("n", "<leader>vs", ":vsplit<CR>", M.keyargs({ "noremap", "silent" })) -- splite buffer vertical
keyset("n", "<leader>hs", ":split<CR>", M.keyargs({ "noremap", "silent" })) -- splite buffer vertical
-- keyset("n", "<leader>sa", ":mksession!s.vim<CR>", M.keyargs({ "noremap", "silent" })) -- save session on cwd
keyset("n", "<leader>ss", ":wa<CR>", M.keyargs({ "noremap", "silent" })) -- save session on cwd
keyset("n", "<leader>q", ":qa!<CR>", M.keyargs({ "noremap", "silent" })) -- quit window by force
keyset("n", "<leader>w", ":q!<CR>", M.keyargs({ "noremap", "silent" })) -- delete buffer
keyset("n", "<leader>gg", ":Git<CR>", M.keyargs({ "noremap", "silent" })) -- Git command
keyset("n", "<leader>gc", ":Git commit<CR>", M.keyargs({ "noremap", "silent" })) -- Git commit command
keyset("n", "<leader>gp", ":Git push<CR>", M.keyargs({ "noremap", "silent" })) -- Git commit command
keyset({ "t" }, "<C-n>", "<C-\\><C-n>", M.keyargs({ "silent" }))
keyset({ "n", "x" }, "{", "<C-u>zz")
keyset({ "n", "x" }, "}", "<C-d>zz")
keyset("x", "<leader>p", [["_dP]]) -- paste without losing the copied text
-- move line up and down
keyset("v", "J", ":m '>+1<CR>gv=gv", M.keyargs({ "silent" }))
keyset("v", "K", ":m '<-2<CR>gv=gv", M.keyargs({ "silent" }))
-- half page up and down
-- keyset("n", "<C-d>", "<C-d>zz")
-- keyset("n", "<C-u>", "<C-u>zz")
-- clear search highlight
keyset("n", "<leader>l", ":nohlsearch<CR>", M.keyargs({ "silent" }))
-- tab switching
keyset("n", "<A-[>", ":tabp<CR>", M.keyargs({ "silent" }))
keyset("n", "<A-]>", ":tabn<CR>", M.keyargs({ "silent" }))
--window movement mapping
keyset("n", "<C-j>", "<C-w><C-j>")
keyset("n", "<C-k>", "<C-w><C-k>")
keyset("n", "<C-h>", "<C-w><C-h>")
keyset("n", "<C-l>", "<C-w><C-l>")
--screen adjusment
-- keyset("n", "<C-l>", "<C-y>") -- for up
-- keyset("n", "<C-l>", "<C-e>") -- for down

keyset("n", "<leader>fo", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, M.keyargs({ "noremap", "silent", desc = "conform format" }))

M.mapKeyForNewtab("n", "<leader>tt", function()
  vim.cmd("terminal")
end, M.keyargs({ "noremap", "silent" }))
M.mapKeyForNewtab("n", "<leader>ex", function()
  vim.cmd("Ex")
end, M.keyargs({ "noremap", "silent" }))

M.mapKeyForNewtab("n", "<leader>ef", function(bf)
  local filename = vim.api.nvim_buf_get_name(bf and bf.bufnr or 0)
  vim.cmd("Ex " .. filename:gsub(vim.PM.file.parse(filename).filename, ""))
end, M.keyargs({ "noremap", "silent" }))
--telescope
M.mapKeyForNewtab("n", "<leader>ff", function()
  builtin.find_files(M.telescope_opt({
    hidden = true,
  }))
end, M.keyargs({ "noremap", "silent" }))

M.mapKeyForNewtab("n", "<leader>ls", function()
  vim.cmd("Telescope session-lens search_session")
end, M.keyargs({ "noremap", "silent" }))

M.mapKeyForNewtab("n", "<leader>en", function()
  builtin.find_files(M.telescope_opt({ cwd = vim.fn.stdpath("config") }))
end, M.keyargs({ "noremap", "silent" }))

M.mapKeyForNewtab("n", "<leader>fd", function()
  pm_telescope_ext.find_folders(M.telescope_opt())
end, M.keyargs({ "noremap", "silent" }))

M.mapKeyForNewtab("n", "<leader>fb", function()
  builtin.buffers(M.telescope_opt())
end, M.keyargs({ "noremap", "silent" }))

keyset("n", "<leader>fg", function()
  builtin.live_grep(M.telescope_opt({ previewer = true }))
end, M.keyargs({ "noremap", "silent" }))

keyset("n", "<leader>fh", function()
  builtin.help_tags(M.telescope_opt())
end, M.keyargs({ "noremap", "silent" }))

keyset("n", "<leader>fs", function()
  builtin.lsp_document_symbols(M.telescope_opt({
    fname_width = 40,
    symbol_width = 50,
    symbol_type_width = 16,
  }))
end, M.keyargs({ "noremap", "silent" }))

keyset("n", "<leader>fr", function()
  builtin.lsp_references(M.telescope_opt())
end, M.keyargs({ "noremap", "silent" }))

keyset("n", "<leader>dd", function()
  builtin.diagnostics(M.telescope_opt())
end, M.keyargs({ "noremap", "silent" }))

--lsp-keybinding
vim.api.nvim_create_autocmd("LspAttach", {
  callback = M.on_lsp_attach,
})

--copilot
keyset("i", "<C-S-J>", 'copilot#Accept("")', {
  expr = true,
  replace_keycodes = false,
  noremap = true,
  silent = true,
})

return M
