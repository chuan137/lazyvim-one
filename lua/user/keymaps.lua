local util = require("user.util")
local map = vim.keymap.set

-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Shortcuts
vim.keymap.set({ "n", "x", "o" }, "<leader>h", "^")
vim.keymap.set({ "n", "x", "o" }, "<leader>l", "g_")
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

-- Delete text
vim.keymap.set({ "n", "x" }, "x", '"_x')

-- commands
vim.keymap.set("n", "<leader><space>", "<cmd>buffer #<cr>")
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete<cr>")

vim.keymap.set("n", "<leader>,L", "<cmd>Lazy<cr>")
vim.keymap.set("n", "<leader>,M", "<cmd>Mason<cr>")
vim.keymap.set("n", "<leader>,l", "<cmd>LspInfo<cr>")
vim.keymap.set("n", "<leader>,n", "<cmd>NullLsInfo<cr>")

-- toggle file explorer
vim.keymap.set("n", "<leader>e", util.toggle_netrw, { desc = "explore" })

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<C-s>", "<cmd>w<cr>")
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>qq", "<cmd>qall<cr>", { desc = "Quit all" })


map("n", "<leader>gg", function() util.float_term("lazygit") end, { desc = "Lazy git" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })


-- Basic clipboard interaction
-- vim.keymap.set({ "n", "x" }, "cp", '"+y')
-- vim.keymap.set({ "n", "x" }, "cv", '"+p')
