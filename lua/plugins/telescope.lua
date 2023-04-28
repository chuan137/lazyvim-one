return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  event = "VeryLazy",
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").load_extension("ui-select")
      end,
    },
    {
      "ahmedkhalf/project.nvim",
      opts = {
        scope_chdir = "win",
      },
      config = function()
        require("project_nvim").setup({
          patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml", ".envrc" },
          ignore_lsp = { "efm", "null-ls" },
        })
        require("telescope").load_extension("projects")
      end,
    },
  },
  init = function()
    -- See :help telescope.builtin
    vim.keymap.set("n", "<F1>", "<cmd>Telescope help_tags<cr>", { desc = "help" })
    vim.keymap.set("n", "<F8>", "<cmd>Telescope projects<cr>", { desc = "projects" })
    vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>")
    vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
    vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
  end,
}
