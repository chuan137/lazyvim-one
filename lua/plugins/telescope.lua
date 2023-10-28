local project_root_patterns = {
  ".bzr",
  ".envrc",
  ".git",
  ".hg",
  ".svn",
  "Cargo.toml",
  "Makefile",
  "_darcs",
  "package.json",
  "pyrightconfig.json",
  "requirements.txt",
}

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    event = "VeryLazy", -- use "VeryLazy" to ensure project extension loaded correctly on startup
    version = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
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
          patterns = project_root_patterns,
          ignore_lsp = { "efm", "null-ls" },
        },
        config = function(_, opts)
          require("project_nvim").setup(opts)
          require("telescope").load_extension("projects")
        end,
      },
      {
        "stevearc/aerial.nvim",
        config = function ()
          require("telescope").load_extension("aerial")
        end
      },
    },
    keys = {
      { "<F1>", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<F8>", "<Cmd>Telescope projects<CR>", desc = "Projects" },
      { "<F9>", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
      { "<leader>f<cr>", "<cmd>Telescope resume<cr>", desc = "Resume last search" },

      -- lsp
      { "<leader>ld", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },
      { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "Find references" },

      -- buffers
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

      -- files
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fG", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
      { "<leader>fh", "<cmd>Telescope oldfiles<cr>", desc = "Find old files" },

      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },

      -- search
      { '<leader>f"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },

      -- grep
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "grep" },
      {
        "<leader>f/",
        function()
          require("telescope.builtin").live_grep({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "grep in current dir",
      },
      { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "grep in current buffer" },
      { "<leader>fg", "<cmd>Telescope grep_string<cr>", desc = "grep word" },
      { "<leader>fG", "<cmd>Telescope grep_string grep_open_files=true<cr>", desc = "grep word in opened files" },
      {
        "<leader>fr",
        function()
          require("telescope.builtin").grep_string({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "grep word in current dir",
      },

      -- { -- multiopen
      --   "<CR>",
      --   function(pb)
      --     local actions = require("telescope.actions")
      --     local action_state = require("telescope.actions.state")
      --     local picker = action_state.get_current_picker(pb)
      --     local multi = picker:get_multi_selection()
      --     actions.select_default(pb) -- the normal enter behaviour
      --     for _, j in pairs(multi) do
      --       if j.path ~= nil then -- is it a file -> open it as well:
      --         vim.cmd(string.format("%s %s", "edit", j.path))
      --       end
      --     end
      --   end,
      -- },
    },
    opts = function()
      local actions = require("telescope.actions")
      local actions_layout = require("telescope.actions.layout")


      return {
        defaults = {
          layout_config = {
            prompt_position = "bottom",
            width = 0.9,
            height = 0.9,
            horizontal = {
              preview_width = function(_, cols, _)
                if cols > 200 then
                  return math.floor(cols * 0.4)
                else
                  return math.floor(cols * 0.6)
                end
              end,
            },
          },
          path_display = { truncate = 3 },
          mappings = {
            i = {
              ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<c-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
              ["<c-x>"] = actions.cycle_previewers_next,
              ["<c-y>"] = actions_layout.toggle_preview,
            },
          },
        },
      }
    end,
  },
}
