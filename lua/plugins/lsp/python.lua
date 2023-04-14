return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["pyright"] = {
          settings = {
            pyright = { typeCheckingMode = "basic" },
          },
        },
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.isort)
      table.insert(opts.sources, nls.builtins.formatting.yapf)
    end,
  }
}
