local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["lua_ls"] = {
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                version = "LuaJIT",
                path = runtime_path,
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
              workspace = {
                library = {
                  -- Make the server aware of Neovim runtime files
                  vim.fn.expand("$VIMRUNTIME/lua"),
                  vim.fn.stdpath("config") .. "/lua",
                },
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
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
      table.insert(opts.sources, nls.builtins.formatting.stylua)
    end,
  }
}
