local autocmd = vim.api.nvim_create_autocmd
-- local commantary_group = vim.api.nvim_create_
autocmd("FileType", {
  desc = "set custom indent for files",
  callback = function(opts)
    if vim.PM.g.forward_slash_comment_filext[vim.bo[opts.buf].filetype] then
      vim.opt_local.commentstring = "//%s"
    elseif vim.PM.g.hash_comment_filext[vim.bo[opts.buf].filetype] then
      vim.opt_local.commentstring = "#%s"
    end
    if vim.PM.g.shiftwidth[vim.bo[opts.buf].filetype] ~= nil then
      vim.opt.shiftwidth = vim.PM.g.shiftwidth[vim.bo[opts.buf].filetype]
    end

    -- vim.print(vim.bo[opts.buf].filetype)
    -- if vim.PM.g.file_type_setup[vim.bo[opts.buf].filetype] ~= nil then
    --   vim.PM.g.file_type_setup[vim.bo[opts.buf].filetype]()
    -- end
  end,
})

autocmd("FileType", {
  pattern = { "java", "javascriptreact", "javascript", "css", "rust" }, -- List of file types
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("CenterOnInsert", { clear = true }),
  callback = function()
    vim.cmd("normal! zz")
  end,
})
