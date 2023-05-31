local M = {}

-- toggle netrw
function M.toggle_netrw()
  if vim.bo.filetype == "netrw" then
    vim.cmd("bwipeout")
  else
    vim.cmd("Ex")
  end
end

function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require("lazy.util").float_term(cmd, opts)
end

function M.termnial_background()
  -- get the current background color
  local bg = vim.api.nvim_get_hl_by_name("Normal", true).background
  -- get the hex value of the current background color
  -- local bg_hex = vim.api.nvim_get_color_by_name(bg)
  -- convert the hex value to a string
  local bg_hex_str = string.format("#%06x", bg)
  -- get r, g, b values
  local r, g, b = bg_hex_str:match("#(%x%x)(%x%x)(%x%x)")
  -- convert to numbers
  r, g, b = tonumber(r, 16) + 8, tonumber(g, 16) + 8, tonumber(b, 16) + 16
  -- convert to hex string
  return string.format("#%02x%02x%02x", r, g, b)
end

function M.toggle_term()
  local Terminal = require("toggleterm.terminal").Terminal
  local term = vim.api.nvim_get_var("myTerm")
  if term == nil then
    term = Terminal:new({
      cmd = "zsh",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })
    vim.api.nvim_set_var("myTerm", term)
  end
  print(vim.inspect(term))
  term:toggle()
end

M.icons = {
  diagnostics = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  kinds = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  },
  cmp_menu = {
    nvim_lsp = "",
    luasnip = "",
    buffer = "",
    path = "",
  },
}

-- define a function to import plugin module with relative path and pcall
-- @param path string: relative path of the module
-- @return table: the module
function M.import(path)
  -- get the current file path and remove file name
  local current_path = debug.getinfo(2, "S").source:match("@(.*/)")
  -- get full path from relative path
  path = current_path .. path
  -- remove the part up to lua/
  path = path:match(".*/lua/(.*)")
  local ok, mod = pcall(require, path)
  if not ok then
    print("Error importing " .. path)
    print(mod)
    return nil
  end
  return mod
end

return M
