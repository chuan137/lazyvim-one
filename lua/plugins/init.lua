return {
  { "tpope/vim-fugitive" },
  { "wellle/targets.vim" },
  { "tpope/vim-repeat" },
  { "kyazdani42/nvim-web-devicons" },
  { "numToStr/Comment.nvim",       config = true, event = "VeryLazy" },

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

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   opts = { style = "moon" },
  -- },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
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
}
