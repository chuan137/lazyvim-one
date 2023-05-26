return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    -- enabled = false,
    event = "VeryLazy",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      -- vim.g.copilot_tab_fallback = ""

      vim.keymap.set("i", "<C-H>", "copilot#Previous()", { silent = true, expr = true })
      vim.keymap.set("i", "<C-L>", "copilot#Next()", { silent = true, expr = true })
      vim.keymap.set({ "i", "n" }, "<C-x>", "<cmd>Copilot panel<cr>", { silent = true })
      -- vim.keymap.set("", "<M-\\>", ":Copilot disable<CR>", { noremap = true, silent = true })

      vim.keymap.set("i", "<Right>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
      vim.keymap.set("i", "<C-\\>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })

      -- vim.keymap.set("i", "<S-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })

      -- <shift>-<enter> to remove comment signs on new line.
      -- handy for using copilot, start a new line after typing hints in comment and start accepting suggestions
      -- Note: To send correctly the key sequece (<S-CR>) to vim, keymaps needs to defined in terminal and tmux
      -- ref: https://stackoverflow.com/a/42461580/2153945
      vim.keymap.set("i", "<S-CR>", "<cr><c-u>")
    end,
  },

  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
  },
}
