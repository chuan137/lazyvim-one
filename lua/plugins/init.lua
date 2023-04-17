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

  -- Themes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      custom_highlights = {
        VertSplit = { fg = "#45475a" },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      require("lualine").setup({
        options = {
          theme = "catppuccin",
        },
      })
    end,
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
}
