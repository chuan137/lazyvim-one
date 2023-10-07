local U = require("util")

return {

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- "ray-x/lsp_signature.nvim",
    },
    config = function()
      -- Lsp logging
      vim.lsp.set_log_level("info")
      require("vim.lsp.log").set_format_func(vim.inspect)

      -- ui
      local ui_opts = { border = "rounded" }
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, ui_opts)
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, ui_opts)

      -- load lsp server configs and keymaps from ./servers.lua and ./keymaps.lua
      local servers = require("plugins.lsp.servers") or {}
      local keymaps = require("plugins.lsp.keymaps") or {}

      -- callback on LSP attach
      -- check ":help lsp" for more info
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          keymaps.setup(ev.buf)
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for name, server in pairs(servers) do
        require("lspconfig")[name].setup({
          capabilities = capabilities,
          settings = server["settings"],
        })
      end
    end,
  },

  -- {
  --   "lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- hint_enable = false,
  --     toggle_key = "<C-k>",
  --   },
  -- }

}
