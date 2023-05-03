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

    -- string
    vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<leader>?", "<cmd>Telescope grep_string<cr>")
    vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")

    -- buffer
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<leader>bb", function ()
      require("telescope.builtin").buffers({
        sort_lastused = true,
        ignore_current_buffer = true,
        show_all_buffers = true,
        sorter = require("telescope.sorters").get_substr_matcher(),
      })
    end)

    vim.keymap.set("n", "<F7>", "<cmd>Telescope oldfiles<cr>")
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
  end,
}
