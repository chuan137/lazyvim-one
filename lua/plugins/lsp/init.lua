return {

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
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

      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- stylua: ignore start
        local kopts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, kopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, kopts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, kopts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, kopts)
        vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, kopts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, kopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, kopts)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, kopts)

        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, kopts)
        vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, kopts)
        vim.keymap.set({ "n", "x" }, "<F4>", vim.lsp.buf.code_action, kopts)

        vim.keymap.set("n", "K", vim.lsp.buf.hover, kopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, kopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, kopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, kopts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, kopts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, kopts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, kopts)
      end

      local servers = require("plugins.lsp.servers")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
