return {
  {
    "numToStr/Comment.nvim",
    config = true,
    event = "VeryLazy",
  },

  { "tpope/vim-repeat" },

  {
    "tpope/vim-surround",
    keys = {
      "ds",
      "cs",
      "cS",
      "ys",
      "yS",
      "yss",
      "ySs",
      "ySS",
      { "S",  mode = "x" },
      { "gS", mode = "x" },
    },
  },

  { "wellle/targets.vim" },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- git
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { silent = true })
    end,
  },
  {
    "tpope/vim-rhubarb",
    config = function()
      vim.g.github_enterprise_urls = { "https://github.wdf.sap.corp" }
    end,
  },

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<M-CR>]],
        shade_filetypes = {},
        shade_terminals = false,
        shading_factor = 1,
        start_in_insert = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        highlights = {
          Normal = {
            guibg = vim.g.terminal_background,
          },
          NormalFloat = {
            link = "Normal",
          },
        },
      })
    end,
  },

  {
    "alexghergh/nvim-tmux-navigation",
    opts = {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        -- last_active = "<C-\\>",
        next = "<C-Space>",
      },
    },
  },

  {
    "dstein64/vim-startuptime",
  },

  { 
    "simrat39/symbols-outline.nvim" ,
    config = function (_, opts)
      require("symbols-outline").setup(opts)
    end

  },
}
