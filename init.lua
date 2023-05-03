local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('user.options')
load('user.commands')
load('user.keymaps')
load('user.setup')

pcall(vim.cmd.colorscheme, 'catppuccin')
