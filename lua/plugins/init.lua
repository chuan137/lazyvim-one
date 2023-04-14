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
      local colors = require("catppuccin.palettes").get_palette("mocha")
      -- Define the original color as a hex code
      local hex_color = colors.base

      -- Convert hex color to RGB values
      local r = tonumber(hex_color:sub(2, 3), 16)
      local g = tonumber(hex_color:sub(4, 5), 16)
      local b = tonumber(hex_color:sub(6, 7), 16)

      -- Add 1 to each color component
      r = r + 8
      g = g + 8 
      b = b + 16

      -- Convert RGB values back to hex color
      local new_hex_color = string.format("#%02X%02X%02X", r, g, b)

      -- Print the new hex color
      print(new_hex_color)
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
            guibg = new_hex_color,
          },
          NormalFloat = {
            link = "Normal",
          },
        },
      })
    end,
  },
}
