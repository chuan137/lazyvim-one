local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = augroup("highlight_on_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "copilot.lua", "fugitive*", "git", "qf" },
  group = augroup("q_quit"),
  command = "nnoremap <buffer> q <cmd>quit<cr>",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- create a command calling the function from users.util module
--vim.api.nvim_create_command("TermBackground", function ()
 -- print(util.termnial_background())
--end)
vim.api.nvim_create_user_command("TermBackground", "lua print(require('util').termnial_background())", {})

