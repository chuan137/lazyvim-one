if vim.g.vscode then
  -- VSCode extension
  return
end

-- local load = function(mod)
--   package.loaded[mod] = nil
--   require(mod)
-- end

require("user.options")
require("user.commands")
require("user.keymaps")
require("user.setup")

pcall(vim.cmd.colorscheme, "catppuccin")
