return {

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      char = "▏",
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      use_treesitter = true,
      show_current_context = false,
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "➤" },
        topdelete = { text = "➤" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- keymaps
        map("n", "]g", gs.next_hunk, "Next Hunk")
        map("n", "[g", gs.prev_hunk, "Prev Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
      end,
    },
  },

  {
    "simrat39/symbols-outline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  -- {
  --   "sbdchd/neoformat",
  --   event = "VeryLazy",
  -- },
  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "VeryLazy", "BufNewFile" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git", ".envrc"),
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.isort.with({
            command = "/Users/d067954/Library/Python/3.9/bin/isort",
          }),
          nls.builtins.formatting.yapf.with({
            command = "/Users/d067954/Library/Python/3.9/bin/yapf",
          }),
        },
      }
    end,
  }
}
