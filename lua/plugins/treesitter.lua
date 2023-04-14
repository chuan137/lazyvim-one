local Plugin = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<C-space>", desc = "Increment selection" },
    { "<bs>", desc = "Decrement selection", mode = "x" },
  },
}

-- See :help nvim-treesitter-modules
Plugin.opts = {
  highlight = {
    enable = true,
  },
  -- :help nvim-treesitter-textobjects-modules
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "lua",
    "vim",
    "vimdoc",
    "css",
    "json",
    "yaml",
    "python",
    "go",
  },
  indent = { enable = true, disable = { "python" } },
  context_commentstring = { enable = true, enable_autocmd = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = "<nop>",
      node_decremental = "<bs>",
    },
  },
}

function Plugin.config(name, opts)
  require("nvim-treesitter.configs").setup(opts)
end

return Plugin
