local nls = require("null-ls")

return {
  pyright = {
    settings = {
      pyright = { typeCheckingMode = "basic" },
    },
  },
  null_ls_sources = {
    nls.builtins.formatting.isort,
    nls.builtins.formatting.yapf,
  },
}
