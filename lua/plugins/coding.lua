return {

  {
    "lukas-reineke/indent-blankline.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    event = "VeryLazy",
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
    -- event = { "BufReadPre", "BufNewFile" },
    event = "VeryLazy",
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

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage Hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset Hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Unstage Hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame Line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "Diff This ~" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },

  -- {
  --   "simrat39/symbols-outline.nvim",
  --   event = { "BufReadPost", "BufNewFile" },
  --   opts = {},
  -- },

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
  },

  {
    "stevearc/aerial.nvim",
    opts = {
      layout = {
        max_width = { 50, 0.25 },
      },
      -- Set to false to disable the default mappings.
      default_bindings = true,
      -- If you want to hide the mode display for aerial in the statusline, set this to true.
      disable_statusline = false,
      -- If you want to hide the mode display for aerial in the tabline, set this to true.
      disable_tabline = false,
      -- If you want to hide the mode display for aerial in the laststatusline, set this to true.
      disable_laststatus = false,
      -- If you want to hide the mode display for aerial in a telescope prompt, set this to true.
      disable_telescope_prompt = false,
      -- If you want to hide the mode display for aerial in a quickfix list, set this to true.
      disable_qf = false,
      -- If you want to hide the mode display for aerial in a loclist, set this to true.
      disable_loclist = false,
      -- Set to true if you want to show the aerial window alongside the current window. If false, it will replace the current window.
      open_automatic = false,
      -- Set to true if you want to update the symbols displayed in the aerial window on CursorHold. This can be slow in large files.
      update_on_cursor_hold = false,
      -- Set to true if you want to update the symbols displayed in the aerial window on CursorMoved. This can be slow in large files.
      update_on_cursor_moved = false,
      -- Set to true if you want to update the symbols displayed in the aerial window on InsertEnter. This can be slow in large files.
      update_on_insert_enter = false,
      -- Set to true if you want to update the symbols displayed in the aerial window on BufEnter. This can be slow in large files.
      update_on_buf_enter = false,
      -- Set to true if you want to update the symbols displayed in the aerial window on BufWrite. This can be slow in large files.
      update_on_buf_write = false,
      -- Set to true if you want to update the symbols displayed in the aerial window on BufLeave. This can be slow in large files.
      update_on_buf_leave = false,
      -- Set to true if you want to update the symbols displayed in the aerial window on WinEnter. This can be slow in large files.
      update_on_win_enter = false,
      -- Set to true if you want to update
    },
    keys = {
      { "<leader>o", "<cmd>Telescope aerial<CR>", desc = "Aerial symbols" },
      { "<leader>O", ":AerialToggle!<CR>", desc = "Toggle Aerial" },
    },
    config = function(_, opts)
      require("telescope").load_extension("aerial")
      require("telescope").setup({
        extensions = {
          aerial = {
            -- Display symbols as <root>.<parent>.<symbol>
            show_nesting = {
              ["_"] = false, -- This key will be the default
              json = true, -- You can set the option for specific filetypes
              yaml = true,
            },
          },
        },
      })
      require("aerial").setup(opts)
    end,
  },
}
