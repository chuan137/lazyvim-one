return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
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


      -- <shift>-<enter> or <C-\> to remove comment signs on new line.
      -- handy for using copilot, start a new line after typing hints in comment and start accepting suggestions
      -- Note: To send correctly the key sequece (<S-CR>) to vim, keymaps needs to defined in terminal and tmux
      -- ref: https://stackoverflow.com/a/42461580/2153945
      
      -- vim.keymap.set("i", "<C-\\>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
      -- vim.keymap.set("i", "<S-CR>", "<cr><c-u>")
      vim.keymap.set("i", "<S-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
      vim.keymap.set("i", "<C-\\>", "<cr><c-u>")
    end,
  },

  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
    event = "VeryLazy",
    enabled = false,
    opts = {
      disable_auto_comment = true,
      accept_keymap = "<C-\\>",
      dismiss_keymap = "<C-]>",
      debounce_ms = 800,
      suggestion_color = { gui = "#808080", cterm = 244 },
      exclude_filetypes = { "TelescopePrompt" },
      log_file_path = nil, -- absolute path to Tabnine log file
    },
    config = function(_, opts)
      require("tabnine").setup(opts)
    end,
  },

  {
    "dpayne/CodeGPT.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("codegpt.config")
    end,
  },
  {
    'Exafunction/codeium.vim',
    event = "VeryLazy",
    enabled = false,
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end,
  },
  {
    "james1236/backseat.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("backseat").setup({
        openai_model_id = "gpt-3.5-turbo", --gpt-4 (If you do not have access to a model, it says "The model does not exist")
        -- language = 'english', -- Such as 'japanese', 'french', 'pirate', 'LOLCAT'
        -- split_threshold = 100,
        -- additional_instruction = "Respond snarkily", -- (GPT-3 will probably deny this request, but GPT-4 complies)
        highlight = {
          icon = "", -- ''
          group = "SpecialComment",
        },
      })
    end
  },
}
