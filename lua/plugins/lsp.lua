local function on_lsp_attach(callback)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      callback(client, buffer)
    end,
  })
end

local function lsp_related_ui_adjust()
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  vim.diagnostic.config({
    float = {
      border = "rounded",
      source = "always", -- Or "if_many"
      prefix = " - ",
    },
    severity_sort = true,
    virtual_text = false,
    -- virtual_text = {
    --   prefix = "●",
    --   severity_sort = true,
    -- },
  })

  -- stylua: ignore start
  vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

  vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

local function lspconfig_setup(servers)
  local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function()
      -- set pwd to project root, so that file path in lualine is relative to project root
      -- local client = vim.lsp.get_active_clients()[1]
      -- if vim.tbl_contains(client.config, "root_dir") then
      --   vim.api.nvim_set_current_dir(client.config.root_dir)
      -- end
      -- print("LspAttach")
      -- print(vim.inspect(client.config.root_dir))

      local km_opts = { buffer = true, silent = true }

      vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", km_opts)
      vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", km_opts)
      vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", km_opts)
      vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", km_opts)
      vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", km_opts)
      vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", km_opts)
      vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", km_opts)
      vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", km_opts)
      vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", km_opts)
      vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", km_opts)

      vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", km_opts)
      vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", km_opts)
      vim.keymap.set({ "n", "x" }, "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", km_opts)
    end,
  })

  local lspconfig = require("lspconfig")
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities =
      vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

  -- See :help mason-lspconfig-dynamic-server-setup
  -- default handler
  require("mason-lspconfig").setup_handlers({
    function(server)
      lspconfig[server].setup({})
    end,
  })

  -- custom handlers defined in servers
  local lsp_handlers = {}
  for server, server_opts in pairs(servers) do
    lsp_handlers[server] = function()
      lspconfig[server].setup(server_opts)
    end
  end

  require("mason-lspconfig").setup_handlers(lsp_handlers)

  -- Ensure to install configured lsp servers
  local ensure = {}
  local mason_servers = require("mason-lspconfig").get_mappings().lspconfig_to_mason
  for server, _ in pairs(servers) do
    table.insert(ensure, mason_servers[server])
  end
  require("mason-tool-installer").setup({
    ensure_installed = ensure,
  })

  -- Automatically configure lsp servers after install
  vim.api.nvim_create_autocmd("User", {
    pattern = "MasonToolsUpdateCompleted",
    callback = function()
      require("mason-lspconfig").setup_handlers(lsp_handlers)
    end,
  })
end

return {
  require("plugins.lsp.lua_ls"),
  require("plugins.lsp.python"),

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim",         lazy = true },
      { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true },
    },
    opts = {
      servers = {
        ["tsserver"] = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
      },
    },
    init = function()
      lsp_related_ui_adjust()
    end,
    config = function(_, opts)
      lspconfig_setup(opts.servers)
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, opts)
      opts.root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "LspInstall", "LspUnInstall" },
    config = function()
      require("mason").setup({
        ui = {
          height = 0.8,
          border = "rounded",
        },
      })
    end,
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true

      -- attach to lsp
      on_lsp_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("user.util").icons.kinds,
      }
    end,
  },
}
