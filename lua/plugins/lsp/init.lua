local U = require("util")

return {

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "ray-x/lsp_signature.nvim",
    },
    init = function()
      local ui_opts = { border = "rounded" }
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, ui_opts)
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, ui_opts)
    end,
    config = function()
      -- Lsp logging
      vim.lsp.set_log_level("info")
      require("vim.lsp.log").set_format_func(vim.inspect)

      local nvim_lsp = require("lspconfig")
      local lspsignature_config = {
        bind = true,
        toggle_key = "<C-k>",
      }

      local on_attach = function(client, bufnr)
        require("lsp_signature").on_attach(lspsignature_config, bufnr)

        -- buffer local options
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- mappings
        U.import("keymaps").setup(bufnr)
      end

      -- local servers = require("plugins.lsp.servers")
      local servers = U.import("servers") or {}
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for name, server in pairs(servers) do
        nvim_lsp[name].setup({
          capabilities = capabilities,
          cmd = server["cmd"],
          on_attach = on_attach,
          settings = server["settings"],
        })
      end
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git", ".envrc"),
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.isort.with({
            command = "/Users/d067954/Library/Python/3.9/bin/isort",
          }),
          nls.builtins.formatting.yapf.with({
            command = "/Users/d067954/Library/Python/3.9/bin/yapf",
          }),
        },
      }
    end,
  },

}
